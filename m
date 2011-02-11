From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] at73c213: add support for at73c240 devices
Date: Fri, 11 Feb 2011 09:05:19 -0700
Message-ID: <AANLkTim51W5YmTJai1aZQK7MN4tCXGrVJc+DjR_BnbAP@mail.gmail.com>
References: <1297439772-16209-1-git-send-email-biessmann@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "open list:SOUND" <alsa-devel@alsa-project.org>,
	Takashi Iwai <tiwai@suse.de>, kernel@avr32linux.org,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
To: =?ISO-8859-1?Q?Andreas_Bie=DFmann?= <biessmann@corscience.de>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1297439772-16209-1-git-send-email-biessmann@corscience.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 11, 2011 at 8:56 AM, Andreas Bie=DFmann
<biessmann@corscience.de> wrote:
> at73c240 is a successor of mature at73c213 and nearly register compatible.
>
> See http://www.atmel.com/dyn/resources/prod_documents/doc6484.pdf for
> comparison of these two devices.
>
> Signed-off-by: Andreas Bie=DFmann <biessmann@corscience.de>

Looks okay to me.

Briefly-glanced-at-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0include/linux/spi/at73c213.h | =A0 =A01 +
> =A0sound/spi/at73c213.c =A0 =A0 =A0 =A0 | =A0122 ++++++++++++++++++++++++=
+++++++++---------
> =A0sound/spi/at73c213.h =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A03 files changed, 101 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/spi/at73c213.h b/include/linux/spi/at73c213.h
> index 0f20a70e..26d1f38 100644
> --- a/include/linux/spi/at73c213.h
> +++ b/include/linux/spi/at73c213.h
> @@ -19,6 +19,7 @@
> =A0struct at73c213_board_info {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 ssc_id;
> =A0 =A0 =A0 =A0struct clk =A0 =A0 =A0*dac_clk;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0is_at73c240;
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0shortname[32];
> =A0};
>
> diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
> index 503ffb0..711aae4 100644
> --- a/sound/spi/at73c213.c
> +++ b/sound/spi/at73c213.c
> @@ -709,10 +709,44 @@ AT73C213_MONO_SWITCH("Aux Capture Switch", 0, DAC_C=
TRL, DAC_CTRL_ONAUXIN,
> =A0AT73C213_MONO_SWITCH("Line Capture Switch", 0, DAC_CTRL, 0, 0x03, 0),
> =A0};
>
> +static struct snd_kcontrol_new snd_at73c240_controls[] __devinitdata =3D=
 {
> +AT73C213_STEREO("Master Playback Volume", 0, DAC_LMPG, DAC_RMPG, 0, 0, 0=
x1f, 1),
> +AT73C213_STEREO("Master Playback Switch", 0, DAC_LMPG, DAC_RMPG, 5, 5, 1=
, 1),
> +AT73C213_STEREO("PCM Playback Volume", 0, DAC_LLOG, DAC_RLOG, 0, 0, 0x1f=
, 1),
> +AT73C213_STEREO("PCM Playback Switch", 0, DAC_LLOG, DAC_RLOG, 5, 5, 1, 1=
),
> +AT73C213_MONO_SWITCH("Mono PA Playback Switch", 0, DAC_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(DAC_CTRL_ONPADRV-1), 0x01, 0),
> +{
> + =A0 =A0 =A0 .iface =A0=3D SNDRV_CTL_ELEM_IFACE_MIXER,
> + =A0 =A0 =A0 .name =A0 =3D "PA Playback Volume",
> + =A0 =A0 =A0 .index =A0=3D 0,
> + =A0 =A0 =A0 .info =A0 =3D snd_at73c213_pa_volume_info,
> + =A0 =A0 =A0 .get =A0 =A0=3D snd_at73c213_mono_get,
> + =A0 =A0 =A0 .put =A0 =A0=3D snd_at73c213_mono_put,
> + =A0 =A0 =A0 .private_value =A0=3D PA_CTRL | (PA_CTRL_APAGAIN << 8) | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x0f << 16) | (1 << 24),
> +},
> +AT73C213_MONO_SWITCH("PA Playback Switch", 0, PA_CTRL, (PA_CTRL_APAON-1),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01, 0),
> +{
> + =A0 =A0 =A0 .iface =A0=3D SNDRV_CTL_ELEM_IFACE_MIXER,
> + =A0 =A0 =A0 .name =A0 =3D "Line Capture Volume",
> + =A0 =A0 =A0 .index =A0=3D 0,
> + =A0 =A0 =A0 .info =A0 =3D snd_at73c213_line_capture_volume_info,
> + =A0 =A0 =A0 .get =A0 =A0=3D snd_at73c213_stereo_get,
> + =A0 =A0 =A0 .put =A0 =A0=3D snd_at73c213_stereo_put,
> + =A0 =A0 =A0 .private_value =A0=3D DAC_LLIG | (DAC_RLIG << 8) | (0 << 16=
) | (0 << 19)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (0x1f << 24) | (1 << 22),
> +},
> +AT73C213_MONO_SWITCH("Line Capture Switch", 0, DAC_CTRL, 0, 0x03, 0),
> +};
> +
> =A0static int __devinit snd_at73c213_mixer(struct snd_at73c213 *chip)
> =A0{
> =A0 =A0 =A0 =A0struct snd_card *card;
> =A0 =A0 =A0 =A0int errval, idx;
> + =A0 =A0 =A0 struct snd_kcontrol_new *controls;
> + =A0 =A0 =A0 int controls_size =3D 0;
>
> =A0 =A0 =A0 =A0if (chip =3D=3D NULL || chip->pcm =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -721,9 +755,17 @@ static int __devinit snd_at73c213_mixer(struct snd_a=
t73c213 *chip)
>
> =A0 =A0 =A0 =A0strcpy(card->mixername, chip->pcm->name);
>
> - =A0 =A0 =A0 for (idx =3D 0; idx < ARRAY_SIZE(snd_at73c213_controls); id=
x++) {
> + =A0 =A0 =A0 if (chip->board->is_at73c240) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 controls_size =3D ARRAY_SIZE(snd_at73c240_c=
ontrols);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 controls =3D snd_at73c240_controls;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 controls_size =3D ARRAY_SIZE(snd_at73c213_c=
ontrols);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 controls =3D snd_at73c213_controls;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (idx =3D 0; idx < controls_size; idx++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0errval =3D snd_ctl_add(card,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_ctl_new=
1(&snd_at73c213_controls[idx],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_ctl_new=
1(&controls[idx],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0chip));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (errval < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto cleanup;
> @@ -732,7 +774,7 @@ static int __devinit snd_at73c213_mixer(struct snd_at=
73c213 *chip)
> =A0 =A0 =A0 =A0return 0;
>
> =A0cleanup:
> - =A0 =A0 =A0 for (idx =3D 1; idx < ARRAY_SIZE(snd_at73c213_controls) + 1=
; idx++) {
> + =A0 =A0 =A0 for (idx =3D 1; idx < controls_size + 1; idx++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_kcontrol *kctl;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kctl =3D snd_ctl_find_numid(card, idx);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (kctl)
> @@ -777,7 +819,7 @@ static int __devinit snd_at73c213_ssc_init(struct snd=
_at73c213 *chip)
> =A0static int __devinit snd_at73c213_chip_init(struct snd_at73c213 *chip)
> =A0{
> =A0 =A0 =A0 =A0int retval;
> - =A0 =A0 =A0 unsigned char dac_ctrl =3D 0;
> + =A0 =A0 =A0 unsigned char tmp_reg;
>
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_set_bitrate(chip);
> =A0 =A0 =A0 =A0if (retval)
> @@ -799,7 +841,11 @@ static int __devinit snd_at73c213_chip_init(struct s=
nd_at73c213 *chip)
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_write_reg(chip, DAC_PRECH, 0xff);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_clk;
> - =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, PA_CTRL, (1<<PA_CTR=
L_APAPRECH));
> + =A0 =A0 =A0 if (chip->board->is_at73c240)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_reg =3D (1<<(PA_CTRL_APAPRECH-1));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_reg =3D (1<<PA_CTRL_APAPRECH);
> + =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, PA_CTRL, tmp_reg);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_clk;
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_write_reg(chip, DAC_CTRL,
> @@ -809,11 +855,13 @@ static int __devinit snd_at73c213_chip_init(struct =
snd_at73c213 *chip)
>
> =A0 =A0 =A0 =A0msleep(50);
>
> - =A0 =A0 =A0 /* Stop precharging PA. */
> - =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<PA_CTRL_APALP) | 0x0f);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk;
> + =A0 =A0 =A0 if (!chip->board->is_at73c240) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop precharging PA. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, PA_=
CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<PA_CTRL=
_APALP) | 0x0f);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0msleep(450);
>
> @@ -825,12 +873,18 @@ static int __devinit snd_at73c213_chip_init(struct =
snd_at73c213 *chip)
> =A0 =A0 =A0 =A0msleep(1);
>
> =A0 =A0 =A0 =A0/* Turn on DAC. */
> - =A0 =A0 =A0 dac_ctrl =3D (1<<DAC_CTRL_ONDACL) | (1<<DAC_CTRL_ONDACR)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1<<DAC_CTRL_ONLNOL) | (1<<DAC_CTRL_ONLNO=
R)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable MONO PA */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1<<DAC_CTRL_ONPADRV);
> + =A0 =A0 =A0 if (chip->board->is_at73c240)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_reg =3D (1<<DAC_CTRL_ONDACL) | (1<<DAC_=
CTRL_ONDACR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1<<DAC_CTRL_ONLNOL) | (1=
<<DAC_CTRL_ONLNOR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable MONO PA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1<<(DAC_CTRL_ONPADRV-1));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_reg =3D (1<<DAC_CTRL_ONDACL) | (1<<DAC_=
CTRL_ONDACR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1<<DAC_CTRL_ONLNOL) | (1=
<<DAC_CTRL_ONLNOR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* enable MONO PA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | (1<<DAC_CTRL_ONPADRV);
>
> - =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC_CTRL, dac_ctrl);
> + =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC_CTRL, tmp_reg);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_clk;
>
> @@ -859,9 +913,19 @@ static int __devinit snd_at73c213_chip_init(struct s=
nd_at73c213 *chip)
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_write_reg(chip, DAC_RLIG, 0x11);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_clk;
> - =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC_AUXG, 0x11);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk;
> + =A0 =A0 =A0 if (!chip->board->is_at73c240) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC=
_AUXG, 0x11);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* enable I2S clock */
> + =A0 =A0 =A0 if (chip->board->is_at73c240) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC=
_IS_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<DAC_IS_=
CTRL_IS_CTRL));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_clk;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Enable I2S device, i.e. clock output. */
> =A0 =A0 =A0 =A0ssc_writel(chip->ssc->regs, CR, SSC_BIT(CR_TXEN));
> @@ -915,6 +979,10 @@ static int __devinit snd_at73c213_dev_init(struct sn=
d_card *card,
> =A0 =A0 =A0 =A0memcpy(&chip->reg_image, &snd_at73c213_original_image,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(snd_at73c213_origin=
al_image));
>
> + =A0 =A0 =A0 /* at73c240 has another reset value here */
> + =A0 =A0 =A0 if (chip->board->is_at73c240)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->reg_image[PA_CTRL] =3D 0x0f;
> +
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_ssc_init(chip);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_irq;
> @@ -1043,9 +1111,11 @@ static int __devexit snd_at73c213_remove(struct sp=
i_device *spi)
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_write_reg(chip, DAC_RLIG, 0x11);
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> - =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC_AUXG, 0x11);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 if (!chip->board->is_at73c240) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, DAC=
_AUXG, 0x11);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Turn off PA. */
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
> @@ -1053,10 +1123,12 @@ static int __devexit snd_at73c213_remove(struct s=
pi_device *spi)
> =A0 =A0 =A0 =A0if (retval)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0msleep(10);
> - =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, PA_CTRL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1 << PA_CTRL_APALP) | 0x0f);
> - =A0 =A0 =A0 if (retval)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 if (!chip->board->is_at73c240) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D snd_at73c213_write_reg(chip, PA_=
CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (1 << PA_CTRL_APALP) | 0x0f);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Turn off external DAC. */
> =A0 =A0 =A0 =A0retval =3D snd_at73c213_write_reg(chip, DAC_CTRL, 0x0c);
> diff --git a/sound/spi/at73c213.h b/sound/spi/at73c213.h
> index fd8b372..3712d6e 100644
> --- a/sound/spi/at73c213.h
> +++ b/sound/spi/at73c213.h
> @@ -88,6 +88,9 @@
> =A0#define DAC_MISC_DEEMPEN =A0 =A0 =A0 2
> =A0#define DAC_MISC_NBITS =A0 =A0 =A0 =A0 0
>
> +#define DAC_IS_CTRL =A0 =A0 =A0 =A0 =A0 =A00x0B
> +#define DAC_IS_CTRL_IS_CTRL =A0 =A02
> +
> =A0/* DAC Precharge Control Register */
> =A0#define DAC_PRECH =A0 =A0 =A0 =A0 =A0 =A0 =A00x0C
> =A0#define DAC_PRECH_PRCHGPDRV =A0 =A07
> --
> 1.7.2.3
>
>
> -------------------------------------------------------------------------=
-----
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
