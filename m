From: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add Master Sample Data Mode for SPI
Date: Fri, 10 Feb 2017 20:15:46 -0800 (PST)
Message-ID: <b45f2b32-05ec-44a1-be95-21fad915c1fb@googlegroups.com>
References: <20170210220247.8478-1-viniciusfre@gmail.com>
 <20170211045316.12d939ae@i7>
 <CAEz5UgEGO+3CZ6DGhUgXqHpvXc7PBpsujER7LrVi2sfY7Vmvsw@mail.gmail.com>
 <20170211053309.2759af28@i7>
Reply-To: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_869_908453676.1486786546084"
Cc: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	wens-jdAy2FN1RRM@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Return-path: <linux-sunxi+bncBDNJJSMB6QFRB4U77LCAKGQELJVKRFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170211053309.2759af28@i7>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

------=_Part_869_908453676.1486786546084
Content-Type: multipart/alternative;
	boundary="----=_Part_870_182813277.1486786546085"

------=_Part_870_182813277.1486786546085
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Siarhei,

I'm aware this driver is used by A13 and A10. Indeed, I did test this patch=
=20
in A13 and the bit is set to 1, despite the fact that apparently is not be=
=20
used. But I did not test SPI communication on A13 with max11043.

Em s=C3=A1bado, 11 de fevereiro de 2017 00:33:14 UTC-3, Siarhei Siamashka=
=20
escreveu:
>
> On Sat, 11 Feb 2017 00:05:42 -0300=20
> Vinicius Maciel <vinic...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>> wrote:=20
>
> > Em 10 de fev de 2017 23:53, "Siarhei Siamashka" <siarhei....-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
=20
> <javascript:>>=20
> > escreveu:=20
> >=20
> > > On Fri, 10 Feb 2017 19:02:47 -0300=20
> > > Vinicius Maciel <vinic...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>> wrote:=20
> > >  =20
> > > > In order to work appropriately, the max11043 ADC chip and probably=
=20
> > > > others, needs SPI master samples the data at the correct edge. From=
=20
> > > > max11043 datasheet: "The data at DIN is latched on the rising edge=
=20
> > > > of SCLK". Same to DOUT.=20
> > > >=20
> > > > This patch add Master Sample Data Mode bit in normal sample mode.=
=20
> > > >=20
> > > > Signed-off-by: Vinicius Maciel <vinic...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>>=
=20
> > > > ---=20
> > > >  drivers/spi/spi-sun4i.c | 4 +++-=20
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)=20
> > > >=20
> > > > diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c=20
> > > > index c5cd635c28f3..6325be2ce8d9 100644=20
> > > > --- a/drivers/spi/spi-sun4i.c=20
> > > > +++ b/drivers/spi/spi-sun4i.c=20
> > > > @@ -44,6 +44,7 @@=20
> > > >  #define SUN4I_CTL_CS_MANUAL                  BIT(16)=20
> > > >  #define SUN4I_CTL_CS_LEVEL                   BIT(17)=20
> > > >  #define SUN4I_CTL_TP                         BIT(18)=20
> > > > +#define SUN4I_CTL_SDM                                BIT(20)=20
> > > >=20
> > > >  #define SUN4I_INT_CTL_REG            0x0c=20
> > > >  #define SUN4I_INT_CTL_RF_F34                 BIT(4)=20
> > > > @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct=20
> device  =20
> > > *dev)  =20
> > > >       }=20
> > > >=20
> > > >       sun4i_spi_write(sspi, SUN4I_CTL_REG,=20
> > > > -                     SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER |  =20
> > > SUN4I_CTL_TP);  =20
> > > > +                     SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER |=20
> SUN4I_CTL_TP  =20
> > > |  =20
> > > > +                     SUN4I_CTL_SDM);=20
> > > >=20
> > > >       return 0;=20
> > > >  =20
> > >=20
> > > Thanks! That's a good catch. This particular bit is actually set in=
=20
> the=20
> > > reset default register value, according to the Allwinner A20 manual.=
=20
> > > But on Allwinner A10 and Allwinner A13 it is documented as unused and=
=20
> > > can't be changed (it remains zero even if we try to modify it).=20
> > >=20
> > > So looks like only A20 is affected, because the kernel currently sets=
=20
> a=20
> > > non-standard mode, deviating from both Allwinner's default and normal=
=20
> > > SPI behaviour.=20
> > >=20
> > > You still need to update the summary line to add all the necessary=20
> > > sunxi and spi specific prefixes (see similar commits). Also a similar=
=20
> > > fix most likely needs to be applied to the spi-sun6i.c file too (due=
=20
> > > to the copy-paste curse and code duplication), but I'm not sure if it=
=20
> > > needs to be a part of this patch or a separate one.=20
> > >=20
> > > Reviewed-by: Siarhei Siamashka <siarhei....-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>>=
=20
>
> > Hi Siarhei,=20
> >=20
> > I was really aiming only A20 in this patch.=20
>
> Well, regardless of whether you like it or not, A10 and A13 are also=20
> currently using the same code path. So they are potentially affected.=20
>
> Yes, we may try to introduce a separate compatible property to describe=
=20
> this particular new A20-specific feature, which did not exist in the=20
> older A10/A13 SoCs and then set this bit only for A20 in the SPI=20
> driver. But since A20 is backwards compatible with A10/A13 (as long=20
> as we don't override the default values of the reserved bits in hardware=
=20
> registers) and enabling this particular feature is apparently undesired=
=20
> (it breaks your max11043 ADC use case), it does not seem to be necessary=
=20
> to me right now. Maxime and others may have a different opinion though.=
=20
>
> As for the spi-sun6i.c file, somebody else might encounter the same=20
> problem on A23/A33/H3/H5/A83T/A64 later and waste time debugging=20
> something that had been already resolved by you now. Also having the=20
> spi-sun4i.c and spi-sun6i.c files diverge even more than they are now=20
> is not nice.=20
>
> --=20
> Best regards,=20
> Siarhei Siamashka=20
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_870_182813277.1486786546085
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Siarhei,<div><br></div><div>I&#39;m aware this driver i=
s used by A13 and A10.=C2=A0Indeed, I did test this patch in A13 and the bi=
t is set to 1, despite the fact that apparently is not be used.=C2=A0But I =
did not test SPI communication on A13 with max11043.<br><br>Em s=C3=A1bado,=
 11 de fevereiro de 2017 00:33:14 UTC-3, Siarhei Siamashka  escreveu:<block=
quote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-le=
ft: 1px #ccc solid;padding-left: 1ex;">On Sat, 11 Feb 2017 00:05:42 -0300
<br>Vinicius Maciel &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfus=
cated-mailto=3D"B0NGIK1PBQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&=
#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&=
#39;;return true;">vinic...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:
<br>
<br>&gt; Em 10 de fev de 2017 23:53, &quot;Siarhei Siamashka&quot; &lt;<a h=
ref=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"B0NGIK1PBQAJ=
" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&#39;;return =
true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true;">siarhei..=
..@gmail.com</a>&gt;
<br>&gt; escreveu:
<br>&gt;=20
<br>&gt; &gt; On Fri, 10 Feb 2017 19:02:47 -0300
<br>&gt; &gt; Vinicius Maciel &lt;<a href=3D"javascript:" target=3D"_blank"=
 gdf-obfuscated-mailto=3D"B0NGIK1PBQAJ" rel=3D"nofollow" onmousedown=3D"thi=
s.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;ja=
vascript:&#39;;return true;">vinic...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:
<br>&gt; &gt; =C2=A0
<br>&gt; &gt; &gt; In order to work appropriately, the max11043 ADC chip an=
d probably
<br>&gt; &gt; &gt; others, needs SPI master samples the data at the correct=
 edge. From
<br>&gt; &gt; &gt; max11043 datasheet: &quot;The data at DIN is latched on =
the rising edge
<br>&gt; &gt; &gt; of SCLK&quot;. Same to DOUT.
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; This patch add Master Sample Data Mode bit in normal sam=
ple mode.
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; Signed-off-by: Vinicius Maciel &lt;<a href=3D"javascript=
:" target=3D"_blank" gdf-obfuscated-mailto=3D"B0NGIK1PBQAJ" rel=3D"nofollow=
" onmousedown=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D=
"this.href=3D&#39;javascript:&#39;;return true;">vinic...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
<br>&gt; &gt; &gt; ---
<br>&gt; &gt; &gt; =C2=A0drivers/spi/spi-sun4i.c | 4 +++-
<br>&gt; &gt; &gt; =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-s=
un4i.c
<br>&gt; &gt; &gt; index c5cd635c28f3..6325be2ce8d9 100644
<br>&gt; &gt; &gt; --- a/drivers/spi/spi-sun4i.c
<br>&gt; &gt; &gt; +++ b/drivers/spi/spi-sun4i.c
<br>&gt; &gt; &gt; @@ -44,6 +44,7 @@
<br>&gt; &gt; &gt; =C2=A0#define SUN4I_CTL_CS_MANUAL =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(16)
<br>&gt; &gt; &gt; =C2=A0#define SUN4I_CTL_CS_LEVEL =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(17)
<br>&gt; &gt; &gt; =C2=A0#define SUN4I_CTL_TP =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(18)
<br>&gt; &gt; &gt; +#define SUN4I_CTL_SDM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0BIT(20)
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; =C2=A0#define SUN4I_INT_CTL_REG =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0c
<br>&gt; &gt; &gt; =C2=A0#define SUN4I_INT_CTL_RF_F34 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(4)
<br>&gt; &gt; &gt; @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(=
<wbr>struct device =C2=A0
<br>&gt; &gt; *dev) =C2=A0
<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 }
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 sun4i_spi_write(sspi, SUN4I_CTL_REG=
,
<br>&gt; &gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | =C2=A0
<br>&gt; &gt; SUN4I_CTL_TP); =C2=A0
<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP =C2=A0
<br>&gt; &gt; | =C2=A0
<br>&gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 SUN4I_CTL_SDM);
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; &gt; &gt; =C2=A0
<br>&gt; &gt;
<br>&gt; &gt; Thanks! That&#39;s a good catch. This particular bit is actua=
lly set in the
<br>&gt; &gt; reset default register value, according to the Allwinner A20 =
manual.
<br>&gt; &gt; But on Allwinner A10 and Allwinner A13 it is documented as un=
used and
<br>&gt; &gt; can&#39;t be changed (it remains zero even if we try to modif=
y it).
<br>&gt; &gt;
<br>&gt; &gt; So looks like only A20 is affected, because the kernel curren=
tly sets a
<br>&gt; &gt; non-standard mode, deviating from both Allwinner&#39;s defaul=
t and normal
<br>&gt; &gt; SPI behaviour.
<br>&gt; &gt;
<br>&gt; &gt; You still need to update the summary line to add all the nece=
ssary
<br>&gt; &gt; sunxi and spi specific prefixes (see similar commits). Also a=
 similar
<br>&gt; &gt; fix most likely needs to be applied to the spi-sun6i.c file t=
oo (due
<br>&gt; &gt; to the copy-paste curse and code duplication), but I&#39;m no=
t sure if it
<br>&gt; &gt; needs to be a part of this patch or a separate one.
<br>&gt; &gt;
<br>&gt; &gt; Reviewed-by: Siarhei Siamashka &lt;<a href=3D"javascript:" ta=
rget=3D"_blank" gdf-obfuscated-mailto=3D"B0NGIK1PBQAJ" rel=3D"nofollow" onm=
ousedown=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this=
.href=3D&#39;javascript:&#39;;return true;">siarhei....-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
<br>
<br>&gt; Hi Siarhei,
<br>&gt;=20
<br>&gt; I was really aiming only A20 in this patch.
<br>
<br>Well, regardless of whether you like it or not, A10 and A13 are also
<br>currently using the same code path. So they are potentially affected.
<br>
<br>Yes, we may try to introduce a separate compatible property to describe
<br>this particular new A20-specific feature, which did not exist in the
<br>older A10/A13 SoCs and then set this bit only for A20 in the SPI
<br>driver. But since A20 is backwards compatible with A10/A13 (as long
<br>as we don&#39;t override the default values of the reserved bits in har=
dware
<br>registers) and enabling this particular feature is apparently undesired
<br>(it breaks your max11043 ADC use case), it does not seem to be necessar=
y
<br>to me right now. Maxime and others may have a different opinion though.
<br>
<br>As for the spi-sun6i.c file, somebody else might encounter the same
<br>problem on A23/A33/H3/H5/A83T/A64 later and waste time debugging
<br>something that had been already resolved by you now. Also having the
<br>spi-sun4i.c and spi-sun6i.c files diverge even more than they are now
<br>is not nice.
<br>
<br>--=20
<br>Best regards,
<br>Siarhei Siamashka
<br></blockquote></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_870_182813277.1486786546085--

------=_Part_869_908453676.1486786546084--
