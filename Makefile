TARGET = DSonPSP2
OBJS   = main.o draw.o cpu.o

PREFIX  = $(DEVKITARM)/bin/arm-none-eabi
CC      = $(PREFIX)-gcc
READELF = $(PREFIX)-readelf
OBJDUMP = $(PREFIX)-objdump
CFLAGS  = -Wall -specs=psp2.specs
INC = -I./

all: $(TARGET)_fixup.elf

%_fixup.elf: %.elf
	psp2-fixup -q -S $< $@

$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $^ $(LIBS) -o $@
	
%.o: %.cpp
	$(CC) $(CFLAGS) $^ $(LIBS) -o $@

clean:
	@rm -rf $(TARGET)_fixup.elf $(TARGET).elf $(OBJS)