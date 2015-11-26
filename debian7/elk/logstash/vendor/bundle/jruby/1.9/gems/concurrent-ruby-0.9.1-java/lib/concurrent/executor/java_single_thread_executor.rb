if Concurrent.on_jruby?

  require 'concurrent/executor/executor_service'

  module Concurrent

    # @!macro single_thread_executor
    # @!macro thread_pool_options
    # @!macro abstract_executor_service_public_api
    # @!visibility private
    class JavaSingleThreadExecutor < JavaExecutorService
      include SerialExecutorService

      # @!macro single_thread_executor_method_initialize
      def initialize(opts = {})
        super(opts)
      end

      protected
      
      def ns_initialize(opts)
        @executor = java.util.concurrent.Executors.newSingleThreadExecutor
        @fallback_policy = opts.fetch(:fallback_policy, :discard)
        raise ArgumentError.new("#{@fallback_policy} is not a valid fallback policy") unless FALLBACK_POLICY_CLASSES.keys.include?(@fallback_policy)
        self.auto_terminate = opts.fetch(:auto_terminate, true)
      end
    end
  end
end