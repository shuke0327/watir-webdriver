module Watir
  class TableCell < HTMLElement
    # @private
    attr_writer :locator_class

    def locator_class
      @locator_class || super
    end
  end

  class TableCellCollection < ElementCollection
    attr_writer :locator_class

    def locator_class
      @locator_class || super
    end

    def elements
      # we do this craziness since the xpath used will find direct child rows
      # before any rows inside thead/tbody/tfoot...
      elements = super

      if locator_class == ChildCellLocator
        elements = elements.sort_by { |row| row.attribute(:cellIndex).to_i }
      end

      elements
    end

  end
end