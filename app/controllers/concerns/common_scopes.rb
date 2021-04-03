module CommonScopes
    extend ActiveSupport::Concern

    SCOPE_SUFFIX = { '>' => 'gt', '>=' => 'gte', '<' => 'lt', '<=' => 'lte', '=' => '' }
    SORT_DIRECTIONS = [:asc, :desc]

    module ClassMethods
        def standard_scopes(*arguments)
            attributes, options = get_attributes_and_options(*arguments)

            prefix   = options[:prefix].present? ? options[:prefix].to_s : 'with'
            operator = options[:operator].present? ? options[:operator].to_s : '='
            raise 'please supply a valid operator' unless SCOPE_SUFFIX.has_key?(operator)

            attributes.each do |attribute|
                if operator == '='
                    scope "#{prefix}_#{attribute}", lambda { |value| where(attribute => value) if value.present? }
                    alias_scope "#{prefix}_#{attribute.to_s.pluralize}", "#{prefix}_#{attribute}"
                else
                    scope "#{prefix}_#{attribute}_#{SCOPE_SUFFIX[operator]}", lambda { |value| where("#{table_name}.#{attribute} #{operator} ?", value) if value.present? }
                end
            end
        end
        alias_method :standard_scope, :standard_scopes

        def range_scopes(*arguments)
            attributes, options = get_attributes_and_options(*arguments)

            prefix = options[:prefix].present? ? options[:prefix].to_s : 'with'
            attributes.each do |attribute|
                scope "#{prefix}_#{attribute}", lambda { |params| range(:where, "#{table_name}.#{attribute}", params) }
            end
        end
        alias_method :range_scope, :range_scopes

        def time_scopes(attribute, options = {})
            prefix = options[:prefix].present? ? "#{options[:prefix]}" : ''
            attribute = "#{table_name}.#{attribute}"
            scope "#{prefix}_on",              lambda { |time| where("#{attribute} = ?", time) if time.present? }
            scope "#{prefix}_before",          lambda { |time| where("#{attribute} < ?", time) if time.present? }
            scope "#{prefix}_after",           lambda { |time| where("#{attribute} > ?", time) if time.present? }
            scope "#{prefix}_on_or_before",    lambda { |time| where("#{attribute} <= ?", time) if time.present? }
            scope "#{prefix}_on_or_after",     lambda { |time| where("#{attribute} >= ?", time) if time.present? }
            scope "#{prefix}_between",         lambda { |s_time, e_time| where("#{attribute} BETWEEN ? AND ?", s_time, e_time) if s_time.present? && e_time.present? }
            scope "order_by_#{prefix}_recent", lambda { order(Arel.sql("#{attribute} DESC")) }
            scope "order_by_#{prefix}_time",   lambda { order(Arel.sql("#{attribute} ASC")) }
            alias_scope "order_by_#{prefix}_date", "order_by_#{prefix}_time"
        end
        alias_method :date_scopes, :time_scopes

        def alias_scope(new_scope, old_scope)
            singleton_class.send(:alias_method, new_scope, old_scope)
        end

        def get_attributes_and_options(*arguments)
            options = arguments[-1].is_a?(Hash) ? arguments.pop : {}
            raise ArgumentError, 'please supply at least one attribute.' if arguments.empty?

            [arguments, options]
        end
    end