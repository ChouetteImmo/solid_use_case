module SolidUseCase
  class Command
    include Deterministic::CoreExt::Either
    include CommandUtil

    def self.run(input_hash={})
      self.new.run(input_hash)
    end

    # # # # # # # # #
    # Monad-related #
    # # # # # # # # #

    def fail(type, data={})
      data[:type] = type
      Failure(ErrorStruct.new(data))
    end
  end
end
