--Script de tilesheet (feuille de tuiles)
--Sources: https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-bases-love2d/
-- https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-bases-love2d/?vimeography_gallery=10&vimeography_video=196820692
-- https://www.gamecodeur.fr/liste-ateliers/atelier-tilemap-love2d-deplacements-collisions/

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
--love.graphics.setDefaultFilter("nearest")

--fonction pour calculer des distances (https://love2d.org/wiki/General_math)
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- On crée un tablo dans un tablo pour la map
MapGrid =  {
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

--on déclare les taille de la map et des tuiles afin de pouvoir les modifier (on les met en majuscules afin quand on relit le code, de savoir que ces
--variables ne sont pas censées se modifier..
MAP_WIDTH = 32 --nb colones de map
MAP_HEIGHT = 23 --nb lignes de map
TILE_WIDTH = 53 --largeur en px des tuiles
TILE_HEIGHT = 43

-- On crée un tablo pour le brouillard
FogGrid =  {}

-- On crée une map pour les unités (qui est chargée de 0 ds load)
UnitsGrid =  {}

-- On crée un tablo avec la liste des unités
lstUnits =  {} -- si unité détruite: visible=false (ne pas la del du tablo)
moveUnits =  {} -- contient les déplacements des unités (on calcul un chemin qu'on met ds $moveUnits[id_unité], si $moveUnits[id_unité] vide -> pas de mouvement)
numUnit = 1 -- on attribue un numéro aux unités créées

TileSheet = nil -- on la déclare vide, servira à stocker tilesheet.png
TileTextures = {} -- tablo qui contiendra les tuiles une fois tilesheet.png découpée
TileTypes = {} -- on y mettra le nom des tuilles (ex: 10->herbe)
local UpdateRate = 1
local UpdateTimer -- sert à effectuer des actions pas 60x/sec

CurseurX = 0 -- se modifie avec les touches fléchées afin de délpacer l'affichage de la map
CurseurY = 0

local pointeur = {} -- si pointeur.actif = true alors on affiche qque sec un pointeur sur la case cible (vert lors sélection case, croix si infranchissable..)
pointeur.actif = false
pointeur.x = 0
pointeur.y = 0
pointeur.timer = 0
pointeur.type = 33 -- rouge->34, vert->25, croix->33

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
    moveUnits[numUnit] = {} --on declare moveUnits[id] vide pour les points de cheminement futurs
    moveUnits[numUnit][1] = "0000" -- rempli de 0 afin de ne pas avoir de valeur nulle
    moveUnits[numUnit][2] = "0000"
    --print("xxx pr ctrl $moveUnits["..tostring(numUnit).."][2]: "..moveUnits[1][2])
    -- Position X Y
    mySprite.column = pPosX -- lstUnits[1].column
    mySprite.line = pPosY
    UnitsGrid[pPosY][pPosX] = mySprite.id --on place l'unité ds la grille unités
    mySprite.speed = 10
    mySprite.target = nil -- la case cible est déclarée vide
    mySprite.node = 1 -- pour le calcul du path
    -- Pour les dimensions: on prend celles de la 1ere img
    mySprite.width = mySprite.images[1]:getWidth()
    mySprite.height = mySprite.images[1]:getHeight()
    mySprite.selection = false --true -> on l'affiche sélectionné
    table.insert(lstUnits, mySprite) -- insert_ds_tablo(tablo, element_a_ajouter)
    print("Création de l'unité "..tostring(numUnit).." en case "..tostring(pPosX).."-"..tostring(pPosY).." :)")
    ClearFog(pPosY, pPosX)
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
  pCol = pCol + (CurseurX + 1) -- on ajoute le déplacement de la map (avec le touche c)
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

  -- Pr ctrl on affiche le contenu des grilles: MapGrid, PathGrid, FogGrid et UnitsGrid
  local aa = ""
  print(" -----------------------------")
  print("Grille MapGrid: (sur 10x10)")
  for l=1, 10 do -- 10 lignes
    for c=1, 10 do -- 10 colonnes
      aa = aa.." "..tostring(MapGrid[l][c])
    end
    print(aa)
    aa = ""
  end

  aa = ""
  print(" -----------------------------")
  print("Grille PathGrid: (sur 10x10)")
  for l=1, 10 do -- 10 lignes
    for c=1, 10 do -- 10 colonnes
      aa = aa.." "..tostring(PathGrid[l][c])
    end
    print(aa)
    aa = ""
  end

  aa = ""
  print(" -----------------------------")
  print("Grille FogGrid: (sur 10x10)")
  for l=1, 10 do -- 10 lignes
    for c=1, 10 do -- 10 colonnes
      aa = aa.." "..tostring(FogGrid[l][c])
    end
    print(aa)
    aa = ""
  end

  aa = ""
  print(" -----------------------------")
  print("Grille UnitsGrid: (sur 10x10)")
  for l=1, 10 do -- 10 lignes
    for c=1, 10 do -- 10 colonnes
      aa = aa.." "..tostring(UnitsGrid[l][c])
    end
    print(aa)
    aa = ""
  end
  print(" -----------------------------")

end


function love.mousepressed(x, y, button)
  --hero.selection = true
  local cible = {} --case cible -> là où va se rendre l'unité
  x = (math.floor(x / 53) + 1) -- on traduit la position de la souris en column
  y = (math.floor(y / 43) + 1) -- et en lignes
  print("Pr ctrl la colonne qui vient d'être cliquée sur l'écran est:"..tostring(x))
  x = x + CurseurX -- on ajoute le déplacement de la map (avec le touche c)
  print("Pr ctrl cette colonne correspond sur la map à :"..tostring(x))
  local i --2 variables pour les $colonnes et $lignes
  for i=1, #lstUnits do --boucle du nb d'unités
    --print("Pr ctrl, mouseX:"..tostring(x).." =? lstUnits["..tostring(i).."].column:"..tostring(lstUnits[i].column))
    --print("Pr ctrl, mouseY:"..tostring(y).." =? lstUnits["..tostring(i).."].line:"..tostring(lstUnits[i].line))
    if button == 1 and x == lstUnits[i].column and y == lstUnits[i].line then --si click avec le bouton 1 de la souris et qu'on se trouve sur la case d'une unité
      --print("Pr ctrl $selection pour l'unité "..tostring(i)..": "..tostring(lstUnits[i].selection))
      if lstUnits[i].selection == false then --si l'unité n'est pas deja selectionnée -> on la sélectionne
        lstUnits[i].selection = true
        print("Unité "..tostring(i).." sélectionnée")
      elseif lstUnits[i].selection == true then
        lstUnits[i].selection = false
        print("Unité "..tostring(i).." désélectionnée")
      end
    else --si click avec le bouton 1 de la souris mais qu'on ne se trouve pas sur la case avec une unité
      local id = MapGrid[y][x] --on récupère le contenu de la case de MapGrid
      if isSolid(id) then
        id = 0
        print("Erreur la case sélectionnée pour le mouvement n'est pas franchissable")
        pointeur.actif = true -- on active le pointeur, il sera affiché ds draw
        pointeur.x = x
        pointeur.y = y
        pointeur.type = 33 -- rouge->34, vert->25, croix->33
        pointeur.timer = 25 -- durée d'affichage
      end
      --if lstUnits[i].selection == true then -- sans control si case cible est franchissable
      if lstUnits[i].selection == true and id ~= 0 and UnitsGrid[y][x] == 0 then -- unité est selected ET la case cible est franchissable ET pas d'autre unité
        pointeur.actif = true -- on active le pointeur, il sera affiché ds draw
        pointeur.x = x
        pointeur.y = y
        pointeur.type = 25 -- rouge->34, vert->25, croix->33
        pointeur.timer = 25 -- durée d'affichage

        cible.x = x
        cible.y = y
        print("--- Calcul de mouvement unité "..tostring(i).." ---")
        moveUnits[i] = {} -- on efface s'il y avait déjà un chemin prévu
        print(" case cible, x: "..cible.x..", y: "..cible.y.." pour l'unité "..tostring(i))

        -- Define start and goal locations coordinates
        local startx, starty = (lstUnits[i].column), (lstUnits[i].line)
        print(" case start, x: "..startx..", y: "..starty.." pour l'unité "..tostring(i))

        -- on définit la direction de l'unité
        if x < lstUnits[i].column and y < lstUnits[i].line then
        lstUnits[i].imgCurrent = 6
        end
        if x > lstUnits[i].column and y > lstUnits[i].line then
        lstUnits[i].imgCurrent = 2
        end
        if x > lstUnits[i].column and y < lstUnits[i].line then
        lstUnits[i].imgCurrent = 8
        end
        if x < lstUnits[i].column and y > lstUnits[i].line then
        lstUnits[i].imgCurrent = 4
        end
        if x == lstUnits[i].column and y < lstUnits[i].line then
        lstUnits[i].imgCurrent = 7
        end
        if x == lstUnits[i].column and y > lstUnits[i].line then
        lstUnits[i].imgCurrent = 3
        end
        if x < lstUnits[i].column and y == lstUnits[i].line then
        lstUnits[i].imgCurrent = 5
        end
        if x > lstUnits[i].column and y == lstUnits[i].line then
        lstUnits[i].imgCurrent = 1
        end

        --lstUnits[1].column = (startx - 1) * 53 -- 53px de tuile? ### pk?? ###
        --lstUnits[1].line = (starty - 1) * 43
        -- Calculates the path, and its length
        local path = myFinder:getPath(startx, starty, cible.x, cible.y)
        --tablo xxx
        if path then
          print((" Longeueur du chemin: %.2f"):format(path:getLength()))
          for node, count in path:nodes() do
              --print((" Step: %d - x: %d - y: %d"):format(count, node.x, node.y)) --Step: 3 - x: 8 - y: 10
              --on place les points de cheminement ds $moveUnits
              local coord = "0"
              if node.x < 10 then
                coord = "0"..node.x
              else
                coord = node.x
              end

              if node.y < 10 then
                coord = coord.."0"..node.y
              else
                coord = coord..node.y
              end
              --print(" Coordonnées ajoutées à moveUnits["..tostring(i).."]: "..tostring(coord))
              table.insert(moveUnits[i], coord) -- insert_ds_tablo(tablo, element_a_ajouter)
          end
        end
        --print(" Nb de step ds moveUnits["..tostring(i).."]: "..tostring(#moveUnits[i]).." (donc pour l'unité "..tostring(i)..")")
        print("--- Fin du calcul de mouvement unité "..tostring(i).." ---")
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
   UpdateTimer = 0 -- sert à effectuer des actions pas 60x/sec

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

  print("Création et remplissage de la grille Path..")
  -- la grille PathGrid sert pour le calcul des trajets des unités quand on clique sur une case cible
  PathGrid = {}
  -- on la rempli avec les donnée de MapGrid (juste Grid actuellement) mais avec des 0 pour le wakable et 1 pr l'infranchissable
  local c, l --2 variables pour les $colonnes et $lignes
  for l=1, MAP_HEIGHT do --boucle de 1 au nb de lignes
    PathGrid[l] = {}
    for c=1, MAP_WIDTH do --boucle de 1 au nb de colonnes
      local id = MapGrid[l][c] --on récupère le contenu de la case de MapGrid
      if isSolid(id) then -- ca retourne true si infranchissable
        PathGrid[l][c] = 1 --on met 1 ds $PathGrid si infranchissable
      else
        PathGrid[l][c] = 0 --on met 0 ds $PathGrid si wakable
      end
    end
  end
  print("Création de la grille Path terminé.")

  -- PATH-------------------------
  -- Value for walkable tiles
  local walkable = 0
  -- Library setup
  local jump = require("jumper.grid") -- The grid class
  local Pathfinder = require("jumper.pathfinder") -- The pathfinder class
  -- Creates a grid object
  local grid2 = jump(PathGrid)
  -- Creates a pathfinder object using Jump Point Search
  myFinder = Pathfinder(grid2, "BFS", walkable)
  -- -----------------------------

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

  print("Création de la grille des unités, et son remplissage vide..")
  UnitsGrid = {} -- on le vide au cas où il ne l'était pas
  local c, l --2 variables pour les $colonnes et $lignes
  for l=1, MAP_HEIGHT do --boucle de 1 à 10 car il y a 10 lignes
    UnitsGrid[l] = {} --on crée une ligne vide
    for c=1, MAP_WIDTH do --boucle des 10 colonnes
      UnitsGrid[l][c] = 0 -- par défaut la case contient 0 = vide (si unité: on met son id)
    end
  end
  print("Grille des unités terminée.")

  --ClearFog(hero.line, hero.column)
end


function love.update(dt)
   --fonction est appelée en permanence
   --'dt' signifie 'delta temps' c'est le nombre de secondes depuis la dernière fois que cette fonction a été appelée

  --Création nouvelle unité tank
  if love.keyboard.isDown("x") then
    local newTank = CreateTank(8,12)
    print("- - - Création nouvelle unité en 8-12 - - -")
    print("Pr ctrl nb d'élément ds lstUnits: "..tostring(#lstUnits))
    print("** ctrl de l'id de l'unité en 8-12?: "..tostring(UnitsGrid[12][8]))
    --print("Pr ctrl vitesse du 1er élément ds lstUnits: "..tostring(lstUnits[1].speed))
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
      local id = MapGrid[hero.line][hero.column] --on va chercher dans la grille de la map à la poition du hero
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

  -- UpdateTimer est utilisé afin de ne pas faire cette action 60x/sec
  UpdateTimer = UpdateTimer + (dt * 1) -- UpdateTimer+dt->toute les 1sec, UpdateTimer+(dt*4)->toute les 1/4sec
  if UpdateTimer > UpdateRate then -- if afin de ne pas renvoyer 60x par seconde
    UpdateTimer=UpdateTimer-UpdateRate
    --print("S'affiche 1x/sec")
    local i
    --moveUnits[1] = {} -- ### maque ca qque part ###
    --moveUnits[1][2] = "0"
    --print("$moveUnits[1][2]: "..moveUnits[1][2])
    for i=1, #lstUnits do --boucle du nb d'unité
      if moveUnits[i] ~= nil and moveUnits[i][2] ~= "0000" then --si tablo $moveUnits[id_unité] n'est pas vide -> on le déplace
        -- ### AJOUTER PRISE EN CHARGE D'UNE DIRECTION ###
        --print("$moveUnits["..tostring(i).."][2]: "..moveUnits[i][2]) -- ### pk peut être vide?? est vidée + bas quand on efface le tablo moveUnits?? ###
        local moveX = string.sub(moveUnits[i][2],1,2) -- récupère les 2 premiers caractères (on prend $moveUnits[1][2] car $moveUnits[1][1] contient la case de depart)
        local moveY = string.sub(moveUnits[i][2],3,4) -- récupère les 2 derniers caractères
        --print("$moveUnits["..tostring(i).."][2]: "..moveUnits[i][2].." | $moveX: "..moveX.." | moveY: "..moveY)
        if lstUnits[i].column < tonumber(moveX) then -- on veut se déplacer à droite, on check si c'est libre à droite
          -- ### AJOUTER TEST SI CASE EST TJS LIBRE, SI NON -> EFFACE LE TABLO $moveUnits[i] ###
          lstUnits[i].column = lstUnits[i].column + 1 -- on change les coordonnées de l'unité dans le tablo $lstUnits
          UnitsGrid[lstUnits[i].line][lstUnits[i].column] = lstUnits[i].id -- et ds $UnitsGrid
          UnitsGrid[lstUnits[i].line][(lstUnits[i].column - 1)] = 0 -- on efface l'ancienne position
          print("L'unité "..tostring(i).." a été déplacée sur la droite sur "..tostring(lstUnits[i].column)..".")
        elseif lstUnits[i].column > tonumber(moveX) then -- on veut se déplacer à gauche, on check si c'est libre à gauche
          -- ### AJOUTER TEST SI CASE EST TJS LIBRE, SI NON -> EFFACE LE TABLO $moveUnits[i] ###
          lstUnits[i].column = lstUnits[i].column - 1 -- on change les coordonnées de l'unité dans le tablo $lstUnits
          UnitsGrid[lstUnits[i].line][lstUnits[i].column] = lstUnits[i].id -- et ds $UnitsGrid
          UnitsGrid[lstUnits[i].line][(lstUnits[i].column + 1)] = 0 -- on efface l'ancienne position
          print("L'unité "..tostring(i).." a été déplacée sur la gauche sur "..tostring(lstUnits[i].column)..".")
        end
        if lstUnits[i].line < tonumber(moveY) then -- on veut se déplacer en haut, on check si c'est libre en haut
          -- ### AJOUTER TEST SI CASE EST TJS LIBRE, SI NON -> EFFACE LE TABLO $moveUnits[i] ###
          lstUnits[i].line = lstUnits[i].line + 1 -- on change les coordonnées de l'unité dans le tablo $lstUnits
          UnitsGrid[lstUnits[i].line][lstUnits[i].column] = lstUnits[i].id -- et ds $UnitsGrid
          UnitsGrid[(lstUnits[i].line - 1)][lstUnits[i].column] = 0 -- on efface l'ancienne position
          print("L'unité "..tostring(i).." a été déplacée en haut sur "..tostring(lstUnits[i].line)..".")
        elseif lstUnits[i].line > tonumber(moveY) then -- on veut se déplacer en bas, on check si c'est libre en en bas
          -- ### AJOUTER TEST SI CASE EST TJS LIBRE, SI NON -> EFFACE LE TABLO $moveUnits[i] ###
          lstUnits[i].line = lstUnits[i].line - 1 -- on change les coordonnées de l'unité dans le tablo $lstUnits
          UnitsGrid[lstUnits[i].line][lstUnits[i].column] = lstUnits[i].id -- et ds $UnitsGrid
          UnitsGrid[(lstUnits[i].line + 1)][lstUnits[i].column] = 0 -- on efface l'ancienne position
          print("L'unité "..tostring(i).." a été déplacée en bas sur "..tostring(lstUnits[i].line)..".")
        end
        ClearFog(lstUnits[i].line, lstUnits[i].column) -- on efface le brouillard autour
        -- on efface le mouvement dans le tablo $moveUnits (le 2e élément puisque le 1er contient la case de départ et n'est pas utilisé)
        -- Pour info, en lua on ne peut pas supprimer un élément d'un tablo, donc
        local del
        for del=2, #moveUnits[i] do
          --print("pr ctrl ligne "..tostring(del).." devient la ligne "..tostring(del+1).."..")
          moveUnits[i][del] = moveUnits[i][(del+1)] -- on re-rempli le tablo, en sautant la ligne 2: ligne[i][2] devient ligne[i][3]
        end

        if #moveUnits[i] < 2 then -- on a effacé tous les éléments, on remet "0000" sur les positions 1 et 2
          moveUnits[i][1] = "0000" -- rempli de 0 afin de ne pas avoir de valeur nulle
          moveUnits[i][2] = "0000"
        end
      end
    end
  end
end

function love.draw()
  local c, l --2 variables pour les $colonnes et $lignes
  --l = CurseurX -- se modifie avec les touches fléchées afin de délpacer l'affichage de la map
  --c = CurseurY
  for l=1, MAP_HEIGHT do --boucle du nb de lignes
    for c=1, MAP_WIDTH do --boucle du nb de colonnes
      --on récupère les cases (on crée les id des tuiles)
      local id = MapGrid[l][c + CurseurX] -- le +CurseurX s'est pour prendre en compte le déplacement de la map (actuellement avec la touche c)
      --on regarde à quelle image correspond ce numéro id
      local texQuad = TileTextures[id]
      --on affiche l'image, si n'est pas nil (pas == 0)
      if texQuad ~= nil then -- n'est pas '!=' s'écrit en Lua: '~='
        local x = (c-1)*TILE_WIDTH
        local y = (l-1)*TILE_HEIGHT
        --la colone-1  fois largeur de tuile -> 0x70=posX:0, 1x70=posX:70, 2x70=posX:140..
        love.graphics.draw(TileSheet, texQuad, x, y,0,1,1)
        --print("Ctrl (c-CurseurX)-1): "..tostring((c-CurseurX)-1))
        --print("Ctrl CurseurX: "..tostring(CurseurX))
        --print("Ctrl x: "..tostring(x))
        --on dessine le brouillard
        if FogGrid[l][c] > 0 then -- si ds $FrogGrid à cette case, j'ai qque chose > 0 alors -> brouillard ### est-ce qu'il faut faire: FogGrid[l][c+CurseurX]?? ###
          love.graphics.setColor(0,0,0) --on definit du noir pour le brouillard
          love.graphics.rectangle("fill", x, y, TILE_WIDTH, TILE_HEIGHT) --on dessine un rectange a poitionX-Y et de taille largeur_tuile
          love.graphics.setColor(255,255,255) --on remet en blanc
        end
      end
    end
  end

  -- On dessine les unités par dessus les tuiles (UnitsGrid[y][x] contient l'id de l'unité présente sur la case X-Y)
  for l=1, MAP_HEIGHT do --boucle du nb de lignes
    for c=(1+CurseurX), MAP_WIDTH do --boucle du nb de colonnes
      if UnitsGrid[l][c] > 0 then -- si ds $UnitsGrid à cette case, j'ai qque chose > 0 alors
        local x = ((c-1)-CurseurX)*TILE_WIDTH
        local y = (l-1)*TILE_HEIGHT
        --on affiche $lstUnits[1].images[lstUnits[1].imgCurrent]
        love.graphics.draw(lstUnits[UnitsGrid[l][c]].images[lstUnits[UnitsGrid[l][c]].imgCurrent],x,y,0,1,1) --sur X-Y rotation:0 échelleX:1 échelleY:1
      end
    end
  end

  --on affiche l'id de la tuile qui e trouve sous le pointeur souris
  local x = love.mouse.getX() --on récupère la poitionX de la souris ### mettre $mouseX plutot que $x ###
  local y = love.mouse.getY()
  -- calcul pour connaitre le numéro de la case (+ d'info dans script Arkanoid)
  local col = math.floor(x / TILE_WIDTH) + 1 -- poitionX souris divisé par la largeur de tuile (et on utilise math.floor par l'avoir sans virgule Ex: 10.9 -> 10)
  local lig = math.floor(y / TILE_HEIGHT) + 1
  --col = col + (CurseurX + 1) -- bug
  if col > 0 and col <= MAP_WIDTH and lig > 0 and lig <= MAP_HEIGHT then -- afin d'empêcher de planter si la mouse est en dehors de la map..
    local id = MapGrid[lig][col] -- récupère l'id de la tuile
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
  if pointeur.actif == true then
    if pointeur.timer > 0 then
      -- On dessine le pointeur (les TileTypes[25à27] sont les pointeurs verts, les [34à36] sont les rouges et [33] est la croix)
      love.graphics.draw(TileSheet, TileTextures[pointeur.type], (pointeur.x-(CurseurX+1))*TILE_WIDTH, (pointeur.y-(CurseurY+1))*TILE_HEIGHT)
      pointeur.timer = pointeur.timer - 1
    else
      pointeur.actif = false
    end
  end

end

function love.keypressed(k)
   if k == 'escape' then
     print("Au revoir mon Héro!")
     love.event.push('quit') -- Quit the game.
   end	
end
