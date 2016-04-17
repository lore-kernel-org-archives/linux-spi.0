From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: Issues with cros_ec and "spi: rockchip: check return value of dmaengine_prep_slave_sg"
Date: Sun, 17 Apr 2016 02:07:44 +0200
Message-ID: <2001833.m4ljKS3hpv@diego>
References: <5681888.LvkE41Ux3K@phil> <32438337.LoARtRoxf0@phil> <CABxcv=kotgZosaLBKV0f1NpwYH8w57k+RT0fS2QL5ZpNWtU-yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
	Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CABxcv=kotgZosaLBKV0f1NpwYH8w57k+RT0fS2QL5ZpNWtU-yA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am Montag, 11. April 2016, 13:54:51 schrieb Javier Martinez Canillas:
> Hello Heiko,
>=20
> Sorry for the late response, I got this email while I was sick and
> forgot to answer when I recovered.
>=20
> On Sat, Apr 2, 2016 at 9:37 AM, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrot=
e:
> > Hi Shawn,
> >=20
> > Am Samstag, 2. April 2016, 17:56:17 schrieb Shawn Lin:
> >> =E5=9C=A8 2016/4/2 7:52, Heiko Stuebner =E5=86=99=E9=81=93:
> >> > it looks like commit ea9849113343 ("spi: rockchip: check return =
value
> >> > of
> >> > dmaengine_prep_slave_sg") negatively affects the cros_ec spi bac=
kend.
> >> >=20
> >> > During boot on the most recent mainline kernel I get:
> >> >=20
> >> > [    1.025480] cros-ec-spi spi0.0: Chrome EC device registered
> >> > [    1.641636] input: cros_ec as
> >> > /devices/platform/ff110000.spi/spi_master/spi0/spi0.0/ff110000.s=
pi:ec@0
> >> >=20
> >> > :keyboard-controller/input/input0 [    2.340214] cros-ec-spi spi=
0.0: EC
> >> >=20
> >> > failed to respond in time
> >> > [    2.357735] cros-ec-spi spi0.0: packet too long (249 bytes, e=
xpected
> >> > 4) [    2.470353] cros-ec-spi spi0.0: EC failed to respond in ti=
me
> >> > [    2.508495] cros-ec-spi spi0.0: packet too long (249 bytes, e=
xpected
> >> > 4) [    2.620176] cros-ec-spi spi0.0: EC failed to respond in ti=
me
> >> > [    2.637345] cros-ec-spi spi0.0: packet too long (249 bytes, e=
xpected
> >> > 4) [    2.750245] cros-ec-spi spi0.0: EC failed to respond in ti=
me
> >> > [    2.767519] cros-ec-spi spi0.0: packet too long (249 bytes, e=
xpected
> >> > 4)
> >> >=20
> >> > The cros-ec works ok after boot without further errors [aka keyb=
oard
> >> > and everything working correctly] and I haven't been able to fig=
ure out
> >> > what goes wrong, but was able to bisect the issue down to the co=
mmit
> >> > mentioned above.
> >>=20
> >> Which Soc I can reproduce it?
> >=20
> > I can see that on both a veyron-pinky as well as a veyron-jerry, so=
 the
> > rk3288-based devices.
> >=20
> >> I'm not able to find out how this commit to break the cros-ec. So =
I
> >> prone to think this commit just expose some issues rather than
> >> introducing negatively affects. I guess, before this commit, cros-=
ec
> >> always get successful transfer, but the reality is that the tranfe=
r
> >> does failed in the early booting stage but spi-rockchip doesn't lo=
g out
> >> anything. If that is the case, that means spi-rockchip fails to pr=
epare
> >> sg for some unknown reasons?
> >=20
> > That is a possibility.
>=20
> I also agree with this theory. AFAICT the mentioned commit is only
> adding some checks so it seems the problem is with on the spi-rockchi=
p
> driver.
>=20
> > I haven't had much experience with both spi and cros-ec and it seem=
s I've
> > forgotten to also include Javier in my Cc-list who die the cros-ec
> > mainlining. I've corrected that now and maybe he has some additiona=
l idea
> > what may go wrong there.
>=20
> Unfortunately I'm neither familiar with Rockchip platforms nor have
> access to Rockchip based Chromebooks to reproduce this issue. But I
> don't see this error on my Exynos based Chromebooks so that's another
> sign that the issue may be in the spi-rockchip driver.
>=20
> I've added to the cc list to Enric and Tomeu who were working on the
> cros_ec drivers lately and AFAIK have access to some Rockchip
> Chromebooks.

I dug a bit further now, and it really seems to be the rockchip-spi (or
more importantly the dma-part) at fault.

If I just set the use_dma always to 0 and thus force pio mode, everythi=
ng
works fine. With dma transfers enabled it seems to bunch commands toget=
her
in some way.

=46or packets that are reported as the controller not responding, it se=
ems
like they were already transfered with the previous to long packet in
cros_ec_cmd_xfer_spi [0]:

[    4.928480] cros-ec-spi spi0.0: packet too long (249 bytes, expected=
 4)
[    4.935104] cros-ec-spi spi0.0: bytes:=20
[    4.949560] 3 f9 0 0 4 0 0 0 4 0 0 0 0 0 0 0 ed ed ed ed ed ed ed ed=
 ed ed ed ed ed ed ed ed 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=20
[    5.010978] cros-ec-spi spi0.0: packet too long (249 bytes, expected=
 4)
[    5.017599] cros-ec-spi spi0.0: bytes:=20
[    5.022044] 3 f9 0 0 4 0 0 0 fa fa fa fa fa fa fa fa ec 3 f9 0 0 4 0=
 0 0 0 0 0 0 ed ed ed 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=20
[    5.071057] cros_ec_spi_receive_packet: needing 124 bytes
[    5.312045] cros-ec-spi spi0.0: EC failed to respond in time
[    5.329564] cros-ec-spi spi0.0: packet too long (249 bytes, expected=
 4)
[    5.336197] cros-ec-spi spi0.0: bytes:=20
[    5.340651] 3 f9 0 0 4 0 0 0 fa fa fa fa fa fa ec 3 f9 0 0 4 0 0 0 0=
 0 0 0 ed ed ed ed ed 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=20
[    5.389937] cros_ec_spi_receive_packet: needing 124 bytes
[    5.597082] cros-ec-spi spi0.0: EC failed to respond in time
[    5.603102] cros_ec_spi_receive_packet: needing 124 bytes
[    5.812077] cros-ec-spi spi0.0: EC failed to respond in time


It also only affects the big packages, all the 10-20 byte long packages
are transfered nicely it seems.

I'll dig further, but if anybody has an idea where the dma-code makes
a wrong turn I would be happy about pointers :-)



[0] diff is:
diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index ebe9b94..24da42a 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -584,6 +589,10 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_dev=
ice *ec_dev,
        if (len > ec_msg->insize) {
                dev_err(ec_dev->dev, "packet too long (%d bytes, expect=
ed %d)",
                        len, ec_msg->insize);
+dev_err(ec_dev->dev, "bytes: ");
+for (i =3D 0; i < len; i++)
+       printk("%x ", ptr[i]);
+printk("\n");
                ret =3D -ENOSPC;
                goto exit;
        }


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
