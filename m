From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
Subject: [PATCH] at73c213: add support for at73c240 devices
Date: Fri, 11 Feb 2011 16:56:11 +0100
Message-ID: <1297439772-16209-1-git-send-email-biessmann@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Takashi Iwai <tiwai@suse.de>,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	=?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>,
	spi-devel-general@lists.sourceforge.net (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	alsa-devel@alsa-project.org (open list:SOUND)
To: kernel@avr32linux.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

at73c240 is a successor of mature at73c213 and nearly register compatib=
le.

See http://www.atmel.com/dyn/resources/prod_documents/doc6484.pdf for
comparison of these two devices.

Signed-off-by: Andreas Bie=C3=9Fmann <biessmann@corscience.de>
---
 include/linux/spi/at73c213.h |    1 +
 sound/spi/at73c213.c         |  122 +++++++++++++++++++++++++++++++++-=
--------
 sound/spi/at73c213.h         |    3 +
 3 files changed, 101 insertions(+), 25 deletions(-)

diff --git a/include/linux/spi/at73c213.h b/include/linux/spi/at73c213.=
h
index 0f20a70e..26d1f38 100644
--- a/include/linux/spi/at73c213.h
+++ b/include/linux/spi/at73c213.h
@@ -19,6 +19,7 @@
 struct at73c213_board_info {
 	int		ssc_id;
 	struct clk	*dac_clk;
+	bool		is_at73c240;
 	char		shortname[32];
 };
=20
diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 503ffb0..711aae4 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -709,10 +709,44 @@ AT73C213_MONO_SWITCH("Aux Capture Switch", 0, DAC=
_CTRL, DAC_CTRL_ONAUXIN,
 AT73C213_MONO_SWITCH("Line Capture Switch", 0, DAC_CTRL, 0, 0x03, 0),
 };
=20
+static struct snd_kcontrol_new snd_at73c240_controls[] __devinitdata =3D=
 {
+AT73C213_STEREO("Master Playback Volume", 0, DAC_LMPG, DAC_RMPG, 0, 0,=
 0x1f, 1),
+AT73C213_STEREO("Master Playback Switch", 0, DAC_LMPG, DAC_RMPG, 5, 5,=
 1, 1),
+AT73C213_STEREO("PCM Playback Volume", 0, DAC_LLOG, DAC_RLOG, 0, 0, 0x=
1f, 1),
+AT73C213_STEREO("PCM Playback Switch", 0, DAC_LLOG, DAC_RLOG, 5, 5, 1,=
 1),
+AT73C213_MONO_SWITCH("Mono PA Playback Switch", 0, DAC_CTRL,
+		     (DAC_CTRL_ONPADRV-1), 0x01, 0),
+{
+	.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name	=3D "PA Playback Volume",
+	.index	=3D 0,
+	.info	=3D snd_at73c213_pa_volume_info,
+	.get	=3D snd_at73c213_mono_get,
+	.put	=3D snd_at73c213_mono_put,
+	.private_value	=3D PA_CTRL | (PA_CTRL_APAGAIN << 8) | \
+		(0x0f << 16) | (1 << 24),
+},
+AT73C213_MONO_SWITCH("PA Playback Switch", 0, PA_CTRL, (PA_CTRL_APAON-=
1),
+		     0x01, 0),
+{
+	.iface	=3D SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name	=3D "Line Capture Volume",
+	.index	=3D 0,
+	.info	=3D snd_at73c213_line_capture_volume_info,
+	.get	=3D snd_at73c213_stereo_get,
+	.put	=3D snd_at73c213_stereo_put,
+	.private_value	=3D DAC_LLIG | (DAC_RLIG << 8) | (0 << 16) | (0 << 19)
+		| (0x1f << 24) | (1 << 22),
+},
+AT73C213_MONO_SWITCH("Line Capture Switch", 0, DAC_CTRL, 0, 0x03, 0),
+};
+
 static int __devinit snd_at73c213_mixer(struct snd_at73c213 *chip)
 {
 	struct snd_card *card;
 	int errval, idx;
+	struct snd_kcontrol_new *controls;
+	int controls_size =3D 0;
=20
 	if (chip =3D=3D NULL || chip->pcm =3D=3D NULL)
 		return -EINVAL;
@@ -721,9 +755,17 @@ static int __devinit snd_at73c213_mixer(struct snd=
_at73c213 *chip)
=20
 	strcpy(card->mixername, chip->pcm->name);
=20
-	for (idx =3D 0; idx < ARRAY_SIZE(snd_at73c213_controls); idx++) {
+	if (chip->board->is_at73c240) {
+		controls_size =3D ARRAY_SIZE(snd_at73c240_controls);
+		controls =3D snd_at73c240_controls;
+	} else {
+		controls_size =3D ARRAY_SIZE(snd_at73c213_controls);
+		controls =3D snd_at73c213_controls;
+	}
+
+	for (idx =3D 0; idx < controls_size; idx++) {
 		errval =3D snd_ctl_add(card,
-				snd_ctl_new1(&snd_at73c213_controls[idx],
+				snd_ctl_new1(&controls[idx],
 					chip));
 		if (errval < 0)
 			goto cleanup;
@@ -732,7 +774,7 @@ static int __devinit snd_at73c213_mixer(struct snd_=
at73c213 *chip)
 	return 0;
=20
 cleanup:
-	for (idx =3D 1; idx < ARRAY_SIZE(snd_at73c213_controls) + 1; idx++) {
+	for (idx =3D 1; idx < controls_size + 1; idx++) {
 		struct snd_kcontrol *kctl;
 		kctl =3D snd_ctl_find_numid(card, idx);
 		if (kctl)
@@ -777,7 +819,7 @@ static int __devinit snd_at73c213_ssc_init(struct s=
nd_at73c213 *chip)
 static int __devinit snd_at73c213_chip_init(struct snd_at73c213 *chip)
 {
 	int retval;
-	unsigned char dac_ctrl =3D 0;
+	unsigned char tmp_reg;
=20
 	retval =3D snd_at73c213_set_bitrate(chip);
 	if (retval)
@@ -799,7 +841,11 @@ static int __devinit snd_at73c213_chip_init(struct=
 snd_at73c213 *chip)
 	retval =3D snd_at73c213_write_reg(chip, DAC_PRECH, 0xff);
 	if (retval)
 		goto out_clk;
-	retval =3D snd_at73c213_write_reg(chip, PA_CTRL, (1<<PA_CTRL_APAPRECH=
));
+	if (chip->board->is_at73c240)
+		tmp_reg =3D (1<<(PA_CTRL_APAPRECH-1));
+	else
+		tmp_reg =3D (1<<PA_CTRL_APAPRECH);
+	retval =3D snd_at73c213_write_reg(chip, PA_CTRL, tmp_reg);
 	if (retval)
 		goto out_clk;
 	retval =3D snd_at73c213_write_reg(chip, DAC_CTRL,
@@ -809,11 +855,13 @@ static int __devinit snd_at73c213_chip_init(struc=
t snd_at73c213 *chip)
=20
 	msleep(50);
=20
-	/* Stop precharging PA. */
-	retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
-			(1<<PA_CTRL_APALP) | 0x0f);
-	if (retval)
-		goto out_clk;
+	if (!chip->board->is_at73c240) {
+		/* Stop precharging PA. */
+		retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
+				(1<<PA_CTRL_APALP) | 0x0f);
+		if (retval)
+			goto out_clk;
+	}
=20
 	msleep(450);
=20
@@ -825,12 +873,18 @@ static int __devinit snd_at73c213_chip_init(struc=
t snd_at73c213 *chip)
 	msleep(1);
=20
 	/* Turn on DAC. */
-	dac_ctrl =3D (1<<DAC_CTRL_ONDACL) | (1<<DAC_CTRL_ONDACR)
-		| (1<<DAC_CTRL_ONLNOL) | (1<<DAC_CTRL_ONLNOR)
-		/* enable MONO PA */
-		| (1<<DAC_CTRL_ONPADRV);
+	if (chip->board->is_at73c240)
+		tmp_reg =3D (1<<DAC_CTRL_ONDACL) | (1<<DAC_CTRL_ONDACR)
+			| (1<<DAC_CTRL_ONLNOL) | (1<<DAC_CTRL_ONLNOR)
+			/* enable MONO PA */
+			| (1<<(DAC_CTRL_ONPADRV-1));
+	else
+		tmp_reg =3D (1<<DAC_CTRL_ONDACL) | (1<<DAC_CTRL_ONDACR)
+			| (1<<DAC_CTRL_ONLNOL) | (1<<DAC_CTRL_ONLNOR)
+			/* enable MONO PA */
+			| (1<<DAC_CTRL_ONPADRV);
=20
-	retval =3D snd_at73c213_write_reg(chip, DAC_CTRL, dac_ctrl);
+	retval =3D snd_at73c213_write_reg(chip, DAC_CTRL, tmp_reg);
 	if (retval)
 		goto out_clk;
=20
@@ -859,9 +913,19 @@ static int __devinit snd_at73c213_chip_init(struct=
 snd_at73c213 *chip)
 	retval =3D snd_at73c213_write_reg(chip, DAC_RLIG, 0x11);
 	if (retval)
 		goto out_clk;
-	retval =3D snd_at73c213_write_reg(chip, DAC_AUXG, 0x11);
-	if (retval)
-		goto out_clk;
+	if (!chip->board->is_at73c240) {
+		retval =3D snd_at73c213_write_reg(chip, DAC_AUXG, 0x11);
+		if (retval)
+			goto out_clk;
+	}
+
+	/* enable I2S clock */
+	if (chip->board->is_at73c240) {
+		retval =3D snd_at73c213_write_reg(chip, DAC_IS_CTRL,
+				(1<<DAC_IS_CTRL_IS_CTRL));
+		if (retval)
+			goto out_clk;
+	}
=20
 	/* Enable I2S device, i.e. clock output. */
 	ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
@@ -915,6 +979,10 @@ static int __devinit snd_at73c213_dev_init(struct =
snd_card *card,
 	memcpy(&chip->reg_image, &snd_at73c213_original_image,
 			sizeof(snd_at73c213_original_image));
=20
+	/* at73c240 has another reset value here */
+	if (chip->board->is_at73c240)
+		chip->reg_image[PA_CTRL] =3D 0x0f;
+
 	retval =3D snd_at73c213_ssc_init(chip);
 	if (retval)
 		goto out_irq;
@@ -1043,9 +1111,11 @@ static int __devexit snd_at73c213_remove(struct =
spi_device *spi)
 	retval =3D snd_at73c213_write_reg(chip, DAC_RLIG, 0x11);
 	if (retval)
 		goto out;
-	retval =3D snd_at73c213_write_reg(chip, DAC_AUXG, 0x11);
-	if (retval)
-		goto out;
+	if (!chip->board->is_at73c240) {
+		retval =3D snd_at73c213_write_reg(chip, DAC_AUXG, 0x11);
+		if (retval)
+			goto out;
+	}
=20
 	/* Turn off PA. */
 	retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
@@ -1053,10 +1123,12 @@ static int __devexit snd_at73c213_remove(struct=
 spi_device *spi)
 	if (retval)
 		goto out;
 	msleep(10);
-	retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
-					(1 << PA_CTRL_APALP) | 0x0f);
-	if (retval)
-		goto out;
+	if (!chip->board->is_at73c240) {
+		retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
+						(1 << PA_CTRL_APALP) | 0x0f);
+		if (retval)
+			goto out;
+	}
=20
 	/* Turn off external DAC. */
 	retval =3D snd_at73c213_write_reg(chip, DAC_CTRL, 0x0c);
diff --git a/sound/spi/at73c213.h b/sound/spi/at73c213.h
index fd8b372..3712d6e 100644
--- a/sound/spi/at73c213.h
+++ b/sound/spi/at73c213.h
@@ -88,6 +88,9 @@
 #define DAC_MISC_DEEMPEN	2
 #define DAC_MISC_NBITS		0
=20
+#define DAC_IS_CTRL		0x0B
+#define DAC_IS_CTRL_IS_CTRL	2
+
 /* DAC Precharge Control Register */
 #define DAC_PRECH		0x0C
 #define DAC_PRECH_PRCHGPDRV	7
--=20
1.7.2.3
