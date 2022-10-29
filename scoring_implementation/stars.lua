--from https://forum.clockworkpi.com/t/pico-8-gamedev-2-stars-space-tutorial/2455

function init_stars()
 -- INIT VARIABLES
 STARS={}
 STAR_COLS={1,2,5,6,7,12}
 WARP_FACTOR=3

 -- CREATE STARFIELD
 for I=1,#STAR_COLS do
  for J=1,10 do
   local S={
    X=rnd(128),
    Y=rnd(128),
    Z=I,
    C=STAR_COLS[I]
   }
   add(STARS,S)
  end 
 end
end

function update_stars()
 -- MOVE STARS
 for S in all(STARS) do
  -- MOVE STAR, BASED ON Z-ORDER DEPTH
  S.Y+=S.Z*WARP_FACTOR/10
  -- WRAP STAR AROUND THE SCREEN
  if (S.Y>128) then
   S.Y=0
   S.X=rnd(128)
  end
 end
end

function draw_stars()
 for S in all(STARS) do
  pset(S.X,S.Y,S.C)
 end
end