all:
	@echo "Error: Please specify a target (clang or lasm)"

clang:
	@gcc p.c -O3 -Iinclude lib/libraylib.a -lGL -lm -lpthread -ldl -lrt -lX11 -o cmain
	@./cmain
	@rm -rf cmain

lasm:
	@nasm -f elf64 code.s -o amain.o
	@gcc amain.o -g -no-pie -Iinclude lib/libraylib.a -lGL -lm -lpthread -ldl -lrt -lX11 -lc -o amain
	@./amain
	@rm -rf amain amain.o
