package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var bruhbf:FlxSprite;
	var smugbf:FlxSprite;

	var richardnormal:FlxSprite;
	var richardsmile:FlxSprite;
	var richardsmug:FlxSprite;
	var richardsurp:FlxSprite;
	var richardchac:FlxSprite;

	var richardangry:FlxSprite;
	var richardangrier:FlxSprite;
	var richardveryangry:FlxSprite;

	var SkipThisShit:FlxText;

	var bgFade:FlxSprite;

	var fuck:Bool = false;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.23, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(50, 350);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);
			case 'get rich':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.animation.addByPrefix('loudOpen', 'speech bubble loud open0', 24, false);
				box.animation.addByIndices('loud', 'AHH speech bubble0', [4], "", 24, true);
			case 'short sale':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.animation.addByPrefix('loudOpen', 'speech bubble loud open0', 24, false);
				box.animation.addByIndices('loud', 'AHH speech bubble0', [4], "", 24, true);
			case 'bankrupt':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
				box.animation.addByPrefix('loudOpen', 'speech bubble loud open0', 24, false);
				box.animation.addByIndices('loud', 'AHH speech bubble0', [4], "", 24, true);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/happy/Upset', 'shared'));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(780, 120).loadGraphic(Paths.image('rich/portraits/Bf/Normal', 'shared'));
		portraitRight.setGraphicSize(Std.int(portraitRight.width * 0.84));
		portraitRight.updateHitbox();
		portraitRight.antialiasing = true;
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		bruhbf = new FlxSprite(780, 120).loadGraphic(Paths.image('rich/portraits/Bf/Surprised', 'shared'));
		bruhbf.setGraphicSize(Std.int(bruhbf.width * 0.84));
		bruhbf.updateHitbox();
		bruhbf.antialiasing = true;
		bruhbf.scrollFactor.set();
		add(bruhbf);
		bruhbf.visible = false;

		smugbf = new FlxSprite(780, 120).loadGraphic(Paths.image('rich/portraits/Bf/Smug', 'shared'));
		smugbf.setGraphicSize(Std.int(smugbf.width * 0.84));
		smugbf.updateHitbox();
		smugbf.antialiasing = true;
		smugbf.scrollFactor.set();
		add(smugbf);
		smugbf.visible = false;
		
		richardnormal = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/happy/Normal', 'shared'));
		richardnormal.updateHitbox();
		richardnormal.scrollFactor.set();
		add(richardnormal);
		richardnormal.visible = false;

		richardsmile = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/happy/Smile', 'shared'));
		richardsmile.updateHitbox();
		richardsmile.scrollFactor.set();
		add(richardsmile);
		richardsmile.visible = false;

		richardsmug = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/happy/Smug', 'shared'));
		richardsmug.updateHitbox();
		richardsmug.scrollFactor.set();
		add(richardsmug);
		richardsmug.visible = false;

		richardsurp = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/happy/Surprised', 'shared'));
		richardsurp.updateHitbox();
		richardsurp.scrollFactor.set();
		add(richardsurp);
		richardsurp.visible = false;

		richardchac = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/happy/Chaching', 'shared'));
		richardchac.updateHitbox();
		richardchac.scrollFactor.set();
		add(richardchac);
		richardchac.visible = false;

		richardangry = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/angry/Angry', 'shared'));
		richardangry.updateHitbox();
		richardangry.scrollFactor.set();
		add(richardangry);
		richardangry.visible = false;

		richardangrier = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/angry/Angrier', 'shared'));
		richardangrier.updateHitbox();
		richardangrier.scrollFactor.set();
		add(richardangrier);
		richardangrier.visible = false;

		richardveryangry = new FlxSprite(20, 40).loadGraphic(Paths.image('rich/portraits/angry/VeryAngry', 'shared'));
		richardveryangry.updateHitbox();
		richardveryangry.scrollFactor.set();
		add(richardveryangry);
		richardveryangry.visible = false;
		
		box.animation.play('normalOpen');
		box.updateHitbox();
		add(box);

		if (hasDialog)
			{
				SkipThisShit = new FlxText(0, FlxG.height * 0.92, -100, "Press SPACE to skip", 32);
				SkipThisShit.font = Paths.font('cour.ttf');
				add(SkipThisShit);
			}


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = Paths.font('cour.ttf');
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = Paths.font('cour.ttf');
		swagDialogue.color = 0xFF3F2021;
		add(swagDialogue);
		

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.visible = false;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		if (fuck)
			dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
			else if (box.animation.curAnim.name == 'loudOpen' && box.animation.curAnim.finished)
				{
					box.animation.play('loud');
					dialogueOpened = true;
				}
		}

		if (FlxG.keys.justPressed.SPACE && dialogueStarted == true)
			{
				if (!isEnding)
				{
					remove(dialogue);
					remove(SkipThisShit);
					isEnding = true;
		
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						smugbf.visible = false;
						bruhbf.visible = false;
						richardnormal.visible = false;
						richardsmile.visible = false;
						richardsurp.visible = false;
						richardchac.visible = false;
						richardsmug.visible = false;
						richardangry.visible = false;
						richardangrier.visible = false;
						richardveryangry.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);
		
					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
					
					super.update(elapsed);
				}
			}

		if (dialogueOpened && !dialogueStarted)
		{
			fuck = true;
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					remove(SkipThisShit);

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						smugbf.visible = false;
						bruhbf.visible = false;
						richardnormal.visible = false;
						richardsmile.visible = false;
						richardsurp.visible = false;
						richardchac.visible = false;
						richardsmug.visible = false;
						richardangry.visible = false;
						richardangrier.visible = false;
						richardveryangry.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'richardup':
				portraitRight.visible = false;
				richardnormal.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				richardsmile.visible = false;
				richardsurp.visible = false;
				richardchac.visible = false;
				richardsmug.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
			case 'richardnormal':
				portraitRight.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				portraitLeft.visible = false;
				richardsmile.visible = false;
				richardsurp.visible = false;
				richardchac.visible = false;
				richardsmug.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardnormal.visible = true;
				}
			case 'richardsmile':
				portraitRight.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				portraitLeft.visible = false;
				richardsmile.visible = false;
				richardsurp.visible = false;
				richardnormal.visible = false;
				richardchac.visible = false;
				richardsmug.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardsmile.visible = true;
				}
			case 'richardsmug':
				portraitRight.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				portraitLeft.visible = false;
				richardsmile.visible = false;
				richardsurp.visible = false;
				richardnormal.visible = false;
				richardchac.visible = false;
				richardsmile.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardsmug.visible = true;
				}
			case 'richardsurprised':
				portraitRight.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				portraitLeft.visible = false;
				richardsmile.visible = false;
				richardsmug.visible = false;
				richardnormal.visible = false;
				richardchac.visible = false;
				richardsmile.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardsurp.visible = true;
				}
			case 'richardchac':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				richardsmile.visible = false;
				richardsmug.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardsmile.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardchac.visible = true;
				}
			case 'richardangry':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				richardsmile.visible = false;
				richardsmug.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardsmile.visible = false;
				richardchac.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardangry.visible = true;
				}
			case 'richardangrier':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				richardsmile.visible = false;
				richardsmug.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardsmile.visible = false;
				richardchac.visible = false;
				richardangry.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardangrier.visible = true;
				}
			case 'richardveryangry':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				richardsmile.visible = false;
				richardsmug.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardsmile.visible = false;
				richardchac.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				box.scale.set(0.8, 0.8);
				box.setPosition(-50, 263);
				box.animation.play('loudOpen');
				box.flipX = true;
				if (!portraitLeft.visible)
				{
					richardveryangry.visible = true;
				}
			case 'bf':
				portraitLeft.visible = false;
				smugbf.visible = false;
				bruhbf.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardchac.visible = false;
				richardsmug.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
			case 'bfbruh':
				portraitLeft.visible = false;
				smugbf.visible = false;
				portraitRight.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardchac.visible = false;
				richardsmug.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(0.8, 0.8);
				box.setPosition(-50, 263);
				box.animation.play('loudOpen');
				box.flipX = false;
				if (!portraitRight.visible)
				{
					bruhbf.visible = true;
				}
			case 'bfsmug':
				portraitLeft.visible = false;
				bruhbf.visible = false;
				portraitRight.visible = false;
				richardnormal.visible = false;
				richardsurp.visible = false;
				richardchac.visible = false;
				richardsmug.visible = false;
				richardangry.visible = false;
				richardangrier.visible = false;
				richardveryangry.visible = false;
				box.scale.set(1, 1);
				box.setPosition(50, 350);
				box.animation.play('normalOpen');
				box.flipX = false;
				if (!portraitRight.visible)
				{
					smugbf.visible = true;
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
