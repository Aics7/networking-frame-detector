library ieee;
use ieee.std_logic_1164.all;


entity detector is
	port ( clock, reset, x: in std_logic;
		y: out std_logic) ;
end detector;

architecture bhv of detector is
	type state is (S0,S1,S2,S3,S4,S5,S6,S7);
	signal s: state;
    
    signal Q_out, QB_out, zero_FC0, zero_FC1, zero_BC0, zero_BC1 : std_logic;
    signal F0,F1,B0,B1 : std_logic_vector(3 downto 0);
    
    
    
    component dec_counter is
      port (clock, clr : in std_logic;
      		zero : out std_logic;
            Q: out std_logic_vector(3 downto 0));
    end component;
    
    component JK_FF is
    PORT( J,K,CLOCK: in std_logic;
        Q, QB: out std_logic);
    end component JK_FF;
    

begin

	--unit digit of frame counter
    FC0: dec_counter port map(clock=>y,clr=>reset,Q=>F0,zero=>zero_FC0);
    --tens digit of frame counter
    FC1: dec_counter port map(clock=>zero_FC0,clr=>reset,Q=>F1,zero=>zero_FC1);
    
    --instantiating JK flip flop for toggle
	JK: JK_FF port map(J=>y,K=>y,CLOCK=>clock,Q=>Q_out,QB=>QB_out);
    
    --unit digit of bit counter
    BC0: dec_counter port map(clock=>clock and Q_out,clr=>reset or y,Q=>B0,zero=>zero_BC0);
    --tens digit of bit counter
    BC1: dec_counter port map(clock=>zero_BC0,clr=>reset or y,Q=>B1,zero=>zero_BC1);
    
	--process that detects the sequence 01111110
	Transitions: process (reset, clock, x)
	begin    
    
		if reset = '1' then s <= S0; 
		--rising edge of clock facilitate state changes depending on input
		elsif (clock'event and clock='1') then
			case s is
				when S0 =>
					if x = '0' then s<=S1; else s<=S0; end if;
				when S1 =>
					if x = '1' then s<=S2; else s<=S1; end if;
				when S2 =>
					if x = '1' then s<=S3; else s<=S1; end if;
				when S3 =>
					if x = '1' then s<=S4; else s<=S1; end if;
				when S4 =>
					if x = '1' then s<=S5; else s<=S1; end if;
				when S5 =>
					if x = '1' then s<=S6; else s<=S1; end if;
				when S6 =>
					if x = '1' then s<=S7; else s<=S1; end if;
				when S7 =>
					if x = '0' then s<=S0; else s<=S0; end if;
			end case;
		end if;
        
        
	end process;
	--process to control output y
	Outputs: process (x,s)
	begin
		y<= '0';
		case s is
			when S0=>
			when S1=>
			when S2=>
			when S3=>
			when S4=>
			when S5=>
			when S6=>
			when S7=>
				if x= '0' then y <= '1';end if;
		end case;
	end process;
    
end bhv;

