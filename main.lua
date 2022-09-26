--Script de tilesheet (feuille de tuiles)
--Sources: https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-bases-love2d/
-- https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-bases-love2d/?vimeography_gallery=10&vimeography_video=196820692
-- https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-love2d-deplacements-collisions/

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
--love.graphics.setDefaultFilter("nearest")

--fonction pour calculer des distances (https://love2d.org/wiki/General_math)
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- On crée un tablo dans un tablo ### on peut renommer $Grid en Grille ###
Grid =  {
  {10, 10, 10, 10, 10, 10, 10, 10, 10, 46, 10, 13, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 11, 11, 11, 10, 55, 10, 13, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 15, 15, 15, 68, 15, 15},
  {10, 10, 46, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 16, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 55, 11, 19, 21, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 68, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 47, 10, 11, 19, 19, 19, 11, 10, 46, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 68, 15, 129, 15},
  {10, 10, 56, 10, 10, 11, 11, 11, 10, 10, 55, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 16, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 46, 10, 13, 14, 14, 14, 14, 14, 14, 14, 15, 129},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 47, 10, 46, 10, 10, 48, 49, 10, 10, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 14},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 56, 10, 55, 46, 10, 57, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 55, 10, 10, 10, 10, 59, 10, 10, 10, 10, 10, 10, 46, 10, 10, 10, 10, 10, 1, 1},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 47, 10, 46, 10, 10, 10, 10, 10, 10, 47, 10, 10, 55, 10, 10, 10, 10, 1, 37, 37},
  {13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 56, 10, 55, 10, 10, 10, 10, 10, 10, 56, 10, 10, 10, 10, 10, 1, 1, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 46, 10, 10, 10, 10, 16, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 50, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 50, 10, 10, 10, 10, 10, 10, 16, 10, 10, 1, 37, 37, 37, 37, 37, 37, 37},
  {14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
  {20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37, 37},
  {19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 1, 37, 37, 37, 37, 37, 37, 37},
  {20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37},
  {21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37, 37},
  {21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37}
  }

-- On crée un tablo pour le brouillard
FogGrid =  {}

-- On crée une map pour les unités (qui est chargée de 0 ds load)
UnitsGrid =  {}

-- On crée un tablo avec la liste des unités
lstUnits =  {} -- si unité détruite: visible=false (ne pas la del du tablo)
numUnit = 1 -- on attribue un numéro aux unités créées

--on déclare les taille de la map et des tuiles afin de pouvoir les modifier (on les met en majuscules afin quand on relit le code, de savoir que ces
--variables ne sont pas censées se modifier..
MAP_WIDTH = 32 --nb colones de map
MAP_HEIGHT = 23 --nb lignes de map
TILE_WIDTH = 53 --largeur en px des tuiles
TILE_HEIGHT = 43

TileSheet = nil -- on la déclare vide, servira à stocker tilesheet.png
TileTextures = {} -- tablo qui contiendra les tuiles une fois tilesheet.png découpée
TileTypes = {} -- on y mettra le nom des tuilles (ex: 10->herbe)

CurseurX = 1 -- se modifie avec les touches fléchées afin de délpacer l'affichage de la map
CurseurY = 1

local hero = {}
hero.images = {}
hero.images[1] = love.graphics.newImage("images/player_1.png")
hero.images[2] = love.graphics.newImage("images/player_2.png")
hero.imgCurrent = 1 -- imgCurrent veut dire image courante (donc l'img courrante commence par la 1)
hero.line = 10 -- poition du héro (pas en pixel mais en
hero.column = 10 -- lignes et en colonnes)
hero.keyPressed = false --key pressée = false (afin de ne pas se déplacer trop vite)
hero.selection = false --true -> on l'affiche sélectionné


function CreateTank(pPosX, pPosY) -- ajoute un sprite à la liste des unités, pnFrame=nb_img
  if UnitsGrid[pPosY][pPosX] == 0 then
    local mySprite = {}
    mySprite.visible = true --passe false si vie < 0
    -- On charge toutes les images
    mySprite.images = {} --stock les img
    mySprite.images[1] = love.graphics.newImage("images/img_tank/b001.png")
    mySprite.images[2] = love.graphics.newImage("images/img_tank/b002.png")
    mySprite.images[3] = love.graphics.newImage("images/img_tank/b003.png")
    mySprite.images[4] = love.graphics.newImage("images/img_tank/b004.png")
    mySprite.images[5] = love.graphics.newImage("images/img_tank/b005.png")
    mySprite.images[6] = love.graphics.newImage("images/img_tank/b006.png")
    mySprite.images[7] = love.graphics.newImage("images/img_tank/b007.png")
    mySprite.images[8] = love.graphics.newImage("images/img_tank/b008.png")
    mySprite.imgCurrent = 1 -- img courante (ds animation)
    mySprite.id = numUnit -- on donne un numéro à l'unité
    numUnit = numUnit + 1
    -- Position X Y
    mySprite.column = pPosX -- lstUnits[1].column
    mySprite.line = pPosY
    UnitsGrid[pPosY][pPosX] = mySprite.id --on place l'unité ds la grille unités
    mySprite.speed = 10
    mySprite.target = nil -- la case cible est déclarée vide
    -- Pour les dimensions: on prend celles de la 1ere img
    mySprite.width = mySprite.images[1]:getWidth()
    mySprite.height = mySprite.images[1]:getHeight()
    mySprite.selection = false --true -> on l'affiche sélectionné
    table.insert(lstUnits, mySprite) -- insert_ds_tablo(tablo, element_a_ajouter)
    return mySprite
  else
    print("Création de l'unité impossible: case "..tostring(pPosX).."-"..tostring(pPosY).." occupée")
  end
end


function isSolid(pID) -- cette fonction est appelée par une condition if, et retourne true si infranchissable
  --(le pID est qu'on reçoit id de la tuile, on met 'p' devant afin de se souvenir que c'est un parametre)
  local tileType = TileTypes[pID] --on va chercher le type en texte pour l'id de la tuile (recu ds pID) ex:"Sable ou Arbre"
  if tileType == "Eau froide" or tileType == "Arbre" or tileType == "Cactus" or tileType == "Arbre mort" or tileType == "Roche" or tileType == "Pierre claire" then
    return true
  end
  return false
end


function ClearFog(pLine, pCol) -- brouillard, joli rond autour du hero
  --aide math: https://love2d.org/wiki/General_math
  --pour rajouter une oppacité: voir fin de la derniere video: https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-love2d-deplacements-collisions
  print("Nettoyage du brouillard")
  --on calcule une distance
  local c, l --2 variables pour les $colonnes et $lignes
  for l=1, MAP_HEIGHT do --boucle de 1 à 10 car il y a 10 lignes
    for c=1, MAP_WIDTH do --boucle des 10 colonnes
      --on parcourt toute la grille, et pour chaque cellule on verifie si elle est à une certaine distance du hero
      if c > 0 and c <= MAP_WIDTH and l > 0 and l <= MAP_HEIGHT then --on vérifie qu'on est pas au bord de la map
        local dist = math.dist(c, l, pCol, pLine) --fonction de distance dans main.lua, entre la case qu'on teste avec la positon pLine reçue en paramètre
        if dist < 4 then --pr voir + loin: mettre 5
          FogGrid[l][c] = 0 --on découvre le brouillard
        end
      end
    end
  end
end


function love.mousepressed(x, y, button)
  --hero.selection = true
  local cible = {} --case cible -> là où va se rendre l'unité
  x = (math.floor(x / 53) + 1) -- on traduit la position de la souris en column
  y = (math.floor(y / 43) + 1) -- et en lignes
  local i --2 variables pour les $colonnes et $lignes
  for i=1, #lstUnits do --boucle du nb d'unités
    if button == 1 and x == lstUnits[i].column and y == lstUnits[i].line then --si click avec le bouton 1 de la souris et qu'on se trouve sur la case d'une unité
      if lstUnits[i].selection == false then --si l'unité n'est pas deja selectionnée -> on la sélectionne
        lstUnits[i].selection = true
        print("Unité "..tostring(i).." sélectionnée")
      elseif lstUnits[i].selection == true then
        lstUnits[i].selection = false
        print("Unité "..tostring(i).." désélectionnée")
      end
    else --si click avec le bouton 1 de la souris mais qu'on ne se trouve pas sur la case avec une unité
      if lstUnits[i].selection == true then
        cible.x = x
        cible.y = y
        print("case cible définie, x: "..cible.x..", y: "..cible.y.." pour l'unité "..tostring(i))
        --jouer son "go"
      end
      lstUnits[i].selection = false --on enleve la sélection
    end
  end
end


function love.load() --fonction setup()
   --on modifie la taille de la fenêtre (défaut: 800x600)
   love.window.setMode(1024,768)

   largeur_ecran = love.graphics.getWidth()
   hauteur_ecran = love.graphics.getHeight()

   -- on appelle la fonction qui charge les textures
  print("Chargement des textures..")
  TileSheet = love.graphics.newImage("images/tilesheet.png")
  --on découpe la tilesheet (feuille de tuiles)
  --on crée un new quad -> nouveau carré (https://love2d.org/wiki/love.graphics.newQuad)
  --on commence par récupérer le nb de colonne ds l'image tilesheet.png: MaVariable:getWidth() divisé par la largeur des tuiles
  local nbColumns = TileSheet:getWidth() / TILE_WIDTH -- calcul nb colonnes
  local nbLines = TileSheet:getHeight() / TILE_HEIGHT -- calcul nb lignes

  --on parcours tilesheet.png pour la découper, les numéros des tuiles sont en suivant et non x-y (donc 10->est la 10ème tuile et non ligne 1, colonne 0)
  local l,c
  local id = 1 --compteur qui sert à numéroter les découpes (img1, img2, img3 ... )
  TileTextures[0] = nil -- TileTextures[0] est déclarée vide, si on l'affiche il laisse un trou sans tuile
  for l=1, nbLines do --boucle de 1 à nb lignes
    for c=1, nbColumns do --boucle de 1 à nb colonnes
      --tuile_à_découperX, tuile_à_découperY, width_tuile, height_tuile, width_tilesheet.png, height_tilesheet.png)
      --la colone-1  fois largeur de tuile -> 0x70=posX:0, 1x70=posX:70, 2x70=posX:140..
      TileTextures[id] = love.graphics.newQuad(
	(c-1)*TILE_WIDTH,
	(l-1)*TILE_HEIGHT,
	TILE_WIDTH,
	TILE_HEIGHT,
	TileSheet:getWidth(),
	TileSheet:getHeight()
	)

      id = id + 1
    end
  end

  --on associe l'id des tuiles à un text qu'on met dans $TileTypes
  TileTypes[10] = "Herbe"
  TileTypes[11] = "Herbe"
  TileTypes[13] = "Sable"
  TileTypes[14] = "Sable"
  TileTypes[15] = "Sable"
  TileTypes[19] = "Eau froide"
  TileTypes[20] = "Eau froide"
  TileTypes[21] = "Eau froide"
  TileTypes[37] = "Lave chaude"
  TileTypes[46] = "Arbre"
  TileTypes[47] = "Arbre"
  TileTypes[48] = "Arbre"
  TileTypes[49] = "Arbre"
  TileTypes[55] = "Arbre"
  TileTypes[56] = "Arbre"
  TileTypes[57] = "Arbre"
  TileTypes[58] = "Arbre"
  TileTypes[59] = "Roche"
  TileTypes[68] = "Cactus"
  TileTypes[129] = "Roche"
  TileTypes[50] = "Arbre mort"
  TileTypes[16] = "Pierre claire"

  print("Chargement terminé.")

  print("Création du brouillard..")
  FogGrid = {} -- on le vide au cas où il ne l'était pas
  local c, l --2 variables pour les $colonnes et $lignes
  for l=1, MAP_HEIGHT do --boucle de 1 à 10 car il y a 10 lignes
    FogGrid[l] = {} --on crée une ligne vide
    for c=1, MAP_WIDTH do --boucle des 10 colonnes
      FogGrid[l][c] = 1 -- par défaut la case contient 1 = enbrumée de brouillard
    end
  end
  print("Brouillard terminé.")

  print("Mise en place des unités ds leur grille..")
  UnitsGrid = {} -- on le vide au cas où il ne l'était pas
  local c, l --2 variables pour les $colonnes et $lignes
  for l=1, MAP_HEIGHT do --boucle de 1 à 10 car il y a 10 lignes
    UnitsGrid[l] = {} --on crée une ligne vide
    for c=1, MAP_WIDTH do --boucle des 10 colonnes
      UnitsGrid[l][c] = 0 -- par défaut la case contient 0 = vide (si unité: on met son id)
    end
  end
  print("Mise en place des unités terminée.")

  ClearFog(hero.line, hero.column)

  local newTank = CreateTank(3,5) -- Pr test, à virer
end


function love.update(dt)
   --fonction est appelée en permanence
   --'dt' signifie 'delta temps' c'est le nombre de secondes depuis la dernière fois que cette fonction a été appelée

  --Création nouvelle unité tank
  if love.keyboard.isDown("x") then
    local newTank = CreateTank(10,10)
    print("Pr ctrl nb d'élément ds lstUnits: "..tostring(#lstUnits))
    print("Pr ctrl l'unité 99 est bien en 10-10?: "..tostring(UnitsGrid[10][10]))
    print("Pr ctrl vitesse du 1er élément ds lstUnits: "..tostring(lstUnits[1].speed))
    --print("Pr ctrl l'img de l'unité: "..tostring(lstUnits[1].images[lstUnits[1].imgCurrent]))
  end

  --Déplacement de la map
  if love.keyboard.isDown("c") and 2 > 1 then -- en même temps on teste qu'il ne soie pas hors de l'écran avec "hero.line > 1"
    CurseurX = CurseurX + 1
    --hero.line = hero.line + 1 --BUG Pas juste..
    print("Pr ctrl déplacement de la map X: "..CurseurX)
  end

  --hero.imgCurrent = hero.imgCurrent + 1 -- pour ralentir l'animation on fait: +0.1 ou même mieux: +(5 fois le deltaTime) afin d'être idem sur tous les ordinateurs
  hero.imgCurrent = hero.imgCurrent + (5 * dt) --on monte à l'img suivante dans $imgCourrante
  if math.floor(hero.imgCurrent) > #hero.images then -- si $imgCourrante > au nombre d'éléments du tablo $hero.images (fait avec le #) C'est + joli que if hero.imgCurrent > 4 :D
    hero.imgCurrent = 1
  end


  --Déplacement du Héro
  if love.keyboard.isDown("up", "right", "down", "left") then --si on presse l'une de ces touches
    if hero.keyPressed == false then -- et que $hero.keyPressed = false

      --plutôt que tester toutes les cases où le hero peut aller, on le déplace et teste sa case, et si rocher -> oups on le remet où il était
      --donc on va mémoriser sa poition initiale
      local old_column = hero.column
      local old_line = hero.line

      if love.keyboard.isDown("up") and hero.line > 1 then -- en même temps on teste qu'il ne soie pas hors de l'écran avec "hero.line > 1"
        hero.line = hero.line - 1
      end

      if love.keyboard.isDown("right") and hero.column < MAP_WIDTH then
        hero.column = hero.column + 1
      end

      if love.keyboard.isDown("down") and hero.line < MAP_HEIGHT then
        hero.line = hero.line + 1
      end

      if love.keyboard.isDown("left") and hero.column > 1 then
        hero.column = hero.column - 1
      end

      --on check si on peut rester sur cette case
      local id = Grid[hero.line][hero.column] --on va chercher dans la grille de la map à la poition du hero
      if isSolid(id) then -- ca retourne true si infranchissable
        print("Tuile infranchissable!") -- debug
        hero.column = old_column -- retourne sur sa case d'origine
        hero.line = old_line
      else
        --si la case n'est pas infranchissable et qu'on a accepter son déplacement -> on appelle clearFog afin d'enlever le brouillard autour de lui
        ClearFog(hero.line, hero.column) -- (appel fonction clearFog version 2 pour un rond plutot qu'un carré en V1)
      end

      hero.keyPressed = true
    end
  else
    hero.keyPressed = false
  end

  --[[
  --Déplacement des unités vers le nord ### déplacement trop rapide ###
  local c, l --2 variables pour les $colonnes et $lignes
  for l=1, MAP_HEIGHT do --boucle du nb de lignes
    for c=1, MAP_WIDTH do --boucle du nb de colonnes
      if UnitsGrid[l][c] > 0 and c > 1 and l > 1 then --si qque chose
        if UnitsGrid[l-1][c] == 0 then --et rien à coté
          UnitsGrid[l-1][c] = UnitsGrid[l][c] --déplace à coté
          UnitsGrid[l][c] = 0 --efface son emplacement
          lstUnits[UnitsGrid[l][c] ].line = lstUnits[i].line -1 -- on déplace la posX ds lstUnits[1].line
          print("déplacement de l'unité sur la case "..tostring(c).."-"..tostring(l).."..")
        end
      end
    end
  end
--]]

end

function love.draw()
  local c, l --2 variables pour les $colonnes et $lignes
  --l = CurseurX -- se modifie avec les touches fléchées afin de délpacer l'affichage de la map
  --c = CurseurY
  for l=1, MAP_HEIGHT do --boucle du nb de lignes
    for c=1, MAP_WIDTH do --boucle du nb de colonnes
      --on récupère les cases (on crée les id des tuiles)
      local id = Grid[l][c]
      --on regarde à quelle image correspond ce numéro id
      local texQuad = TileTextures[id]
      --on affiche l'image, si n'est pas nil (pas == 0)
      if texQuad ~= nil then -- n'est pas '!=' s'écrit en Lua: '~='
        local x = (c-CurseurX)*TILE_WIDTH
        local y = (l-CurseurY)*TILE_HEIGHT
        --la colone-1  fois largeur de tuile -> 0x70=posX:0, 1x70=posX:70, 2x70=posX:140..
        love.graphics.draw(TileSheet, texQuad, x, y)
        --on dessine le brouillard
        if FogGrid[l][c] > 0 then -- si ds $FrogGrid à cette case, j'ai qque chose > 0 alors -> brouillard
          love.graphics.setColor(0,0,0) --on definit du noir pour le brouillard
          love.graphics.rectangle("fill", x, y, TILE_WIDTH, TILE_HEIGHT) --on dessine un rectange a poitionX-Y et de taille largeur_tuile
          love.graphics.setColor(255,255,255) --on remet en blanc
        end
        --on dessine les unités
        if UnitsGrid[l][c] > 0 then -- si ds $FrogGrid à cette case, j'ai qque chose > 0 alors -> brouillard
          --on affiche $lstUnits[1].images[lstUnits[1].imgCurrent]
          love.graphics.draw(lstUnits[UnitsGrid[l][c]].images[lstUnits[UnitsGrid[l][c]].imgCurrent],x,y,0,1,1) --surX-Y rotation:0 échelleX:1 échelleY:1
        end
      end
    end
  end


  --on affiche l'id de la tuile qui e trouve sous le pointeur souris
  local x = love.mouse.getX() --on récupère la poitionX de la souris ### mettre $mouseX plutot que $x ###
  local y = love.mouse.getY()
  -- calcul pour connaitre le numéro de la case (+ d'info dans script Arkanoid)
  local col = math.floor(x / TILE_WIDTH) + 1 -- poitionX souris divisé par la largeur de tuile (et on utilise math.floor par l'avoir sans virgule Ex: 10.9 -> 10)
  local lig = math.floor(y / TILE_HEIGHT) + 1
  if col > 0 and col <= MAP_WIDTH and lig > 0 and lig <= MAP_HEIGHT then -- afin d'empêcher de planter si la mouse est en dehors de la map..
    local id = Grid[lig][col] -- récupère l'id de la tuile
    love.graphics.print("Tuile id: "..tostring(id).." -> "..tostring(TileTypes[id]),1,1)
  end

  --pour afficher le hero, on récuprère la largeur et hauteur des tuiles qu'on a recu en paramètre lors de l'appel de la fonction hero.Draw(pMap, dt)
  local x = (hero.column-1) * TILE_WIDTH --la colone-1  fois largeur de tuile -> 0x70=posX:0, 1x70=posX:70, 2x70=posX:140..
  local y = (hero.line-1) * TILE_HEIGHT -- donc s'il se trouve sur la case 1 -> ca donne 0, case 2-> 70(largeur de tuile)...

  --affichage du hero
  love.graphics.draw(hero.images[math.floor(hero.imgCurrent)],x,y,0,1,1) --on affiche $imgCurrent surX-Y rotation:0 échelleX:1 échelleY:1

  --affichage du tour si une unités est sélectionnée
  local i --2 variables pour les $colonnes et $lignes
  for i=1, #lstUnits do --boucle du nb d'unités
    if lstUnits[i].selection == true then
      --love.graphics.rectangle("line", x, y, 53, 43) --### METTRE LA LARGEUR ET HAUTEUR DE FACON DYNAMIQUE ###
      love.graphics.rectangle("line", ((lstUnits[i].column-1) * TILE_WIDTH + 3), ((lstUnits[i].line-1) * TILE_HEIGHT + 3), 47, 37)
    end
  end

end

function love.keypressed(k)
   if k == 'escape' then
     print("Au revoir mon Héro!")
     love.event.push('quit') -- Quit the game.
   end	
end
