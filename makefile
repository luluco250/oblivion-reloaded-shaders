FXC ?= ./fxc

_SHADER_SOURCES = \
	HDR004.pso.hlsl \
	HDR005.pso.hlsl \
	HDR006.pso.hlsl
SHADER_SOURCES = $(patsubst %,Shaders/%,$(_SHADER_SOURCES))
SHADER_TARGETS = $(patsubst %.hlsl,%,$(SHADER_SOURCES))

%.pso: %.pso.hlsl
	$(FXC) /T ps_3_0 /Fo "$@" "$<"

build: $(SHADER_TARGETS) ;
