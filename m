From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: Issues with cros_ec and "spi: rockchip: check return value of dmaengine_prep_slave_sg"
Date: Sat, 02 Apr 2016 15:37:43 +0200
Message-ID: <32438337.LoARtRoxf0@phil>
References: <5681888.LvkE41Ux3K@phil> <56FF9741.4040304@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FF9741.4040304-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Shawn,

Am Samstag, 2. April 2016, 17:56:17 schrieb Shawn Lin:
> =E5=9C=A8 2016/4/2 7:52, Heiko Stuebner =E5=86=99=E9=81=93:
> > it looks like commit ea9849113343 ("spi: rockchip: check return val=
ue of
> > dmaengine_prep_slave_sg") negatively affects the cros_ec spi backen=
d.
> >=20
> > During boot on the most recent mainline kernel I get:
> >=20
> > [    1.025480] cros-ec-spi spi0.0: Chrome EC device registered
> > [    1.641636] input: cros_ec as
> > /devices/platform/ff110000.spi/spi_master/spi0/spi0.0/ff110000.spi:=
ec@0
> > :keyboard-controller/input/input0 [    2.340214] cros-ec-spi spi0.0=
: EC
> > failed to respond in time
> > [    2.357735] cros-ec-spi spi0.0: packet too long (249 bytes, expe=
cted
> > 4) [    2.470353] cros-ec-spi spi0.0: EC failed to respond in time
> > [    2.508495] cros-ec-spi spi0.0: packet too long (249 bytes, expe=
cted
> > 4) [    2.620176] cros-ec-spi spi0.0: EC failed to respond in time
> > [    2.637345] cros-ec-spi spi0.0: packet too long (249 bytes, expe=
cted
> > 4) [    2.750245] cros-ec-spi spi0.0: EC failed to respond in time
> > [    2.767519] cros-ec-spi spi0.0: packet too long (249 bytes, expe=
cted
> > 4)
> >=20
> > The cros-ec works ok after boot without further errors [aka keyboar=
d
> > and everything working correctly] and I haven't been able to figure=
 out
> > what goes wrong, but was able to bisect the issue down to the commi=
t
> > mentioned above.
>=20
> Which Soc I can reproduce it?

I can see that on both a veyron-pinky as well as a veyron-jerry, so the=
=20
rk3288-based devices.


> I'm not able to find out how this commit to break the cros-ec. So I
> prone to think this commit just expose some issues rather than
> introducing negatively affects. I guess, before this commit, cros-ec
> always get successful transfer, but the reality is that the tranfer
> does failed in the early booting stage but spi-rockchip doesn't log o=
ut
> anything. If that is the case, that means spi-rockchip fails to prepa=
re
> sg for some unknown reasons?

That is a possibility.=20

I haven't had much experience with both spi and cros-ec and it seems I'=
ve=20
forgotten to also include Javier in my Cc-list who die the cros-ec=20
mainlining. I've corrected that now and maybe he has some additional id=
ea=20
what may go wrong there.

> > Reverting the patch silences the cros-ec again. I'll try to look in=
to it
> > further, but maybe you also have an idea what might go wrong.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
