From: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add Master Sample Data Mode for SPI
Date: Sat, 11 Feb 2017 00:05:42 -0300
Message-ID: <CAEz5UgEGO+3CZ6DGhUgXqHpvXc7PBpsujER7LrVi2sfY7Vmvsw@mail.gmail.com>
References: <20170210220247.8478-1-viniciusfre@gmail.com> <20170211045316.12d939ae@i7>
Reply-To: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a1141ddd263f6f40548387d21
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Siarhei Siamashka <siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDNJJSMB6QFRBB777HCAKGQEQZPM6FA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170211045316.12d939ae@i7>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--001a1141ddd263f6f40548387d21
Content-Type: text/plain; charset=UTF-8

Hi Siarhei,

I was really aiming only A20 in this patch.
Em 10 de fev de 2017 23:53, "Siarhei Siamashka" <siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
escreveu:

> On Fri, 10 Feb 2017 19:02:47 -0300
> Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> > In order to work appropriately, the max11043 ADC chip and probably
> > others, needs SPI master samples the data at the correct edge. From
> > max11043 datasheet: "The data at DIN is latched on the rising edge
> > of SCLK". Same to DOUT.
> >
> > This patch add Master Sample Data Mode bit in normal sample mode.
> >
> > Signed-off-by: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/spi/spi-sun4i.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> > index c5cd635c28f3..6325be2ce8d9 100644
> > --- a/drivers/spi/spi-sun4i.c
> > +++ b/drivers/spi/spi-sun4i.c
> > @@ -44,6 +44,7 @@
> >  #define SUN4I_CTL_CS_MANUAL                  BIT(16)
> >  #define SUN4I_CTL_CS_LEVEL                   BIT(17)
> >  #define SUN4I_CTL_TP                         BIT(18)
> > +#define SUN4I_CTL_SDM                                BIT(20)
> >
> >  #define SUN4I_INT_CTL_REG            0x0c
> >  #define SUN4I_INT_CTL_RF_F34                 BIT(4)
> > @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct device
> *dev)
> >       }
> >
> >       sun4i_spi_write(sspi, SUN4I_CTL_REG,
> > -                     SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER |
> SUN4I_CTL_TP);
> > +                     SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP
> |
> > +                     SUN4I_CTL_SDM);
> >
> >       return 0;
> >
>
> Thanks! That's a good catch. This particular bit is actually set in the
> reset default register value, according to the Allwinner A20 manual.
> But on Allwinner A10 and Allwinner A13 it is documented as unused and
> can't be changed (it remains zero even if we try to modify it).
>
> So looks like only A20 is affected, because the kernel currently sets a
> non-standard mode, deviating from both Allwinner's default and normal
> SPI behaviour.
>
> You still need to update the summary line to add all the necessary
> sunxi and spi specific prefixes (see similar commits). Also a similar
> fix most likely needs to be applied to the spi-sun6i.c file too (due
> to the copy-paste curse and code duplication), but I'm not sure if it
> needs to be a part of this patch or a separate one.
>
> Reviewed-by: Siarhei Siamashka <siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> --
> Best regards,
> Siarhei Siamashka
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--001a1141ddd263f6f40548387d21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi Siarhei,</p>
<p dir=3D"ltr">I was really aiming only A20 in this patch. </p>
<div class=3D"gmail_quote">Em 10 de fev de 2017 23:53, &quot;Siarhei Siamas=
hka&quot; &lt;<a href=3D"mailto:siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">siarhei.siamas=
hka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; escreveu:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Fri, 10 Feb 2017 19:02:47 -0300<br>
Vinicius Maciel &lt;<a href=3D"mailto:viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">viniciusfre@gm=
ail.com</a>&gt; wrote:<br>
<br>
&gt; In order to work appropriately, the max11043 ADC chip and probably<br>
&gt; others, needs SPI master samples the data at the correct edge. From<br=
>
&gt; max11043 datasheet: &quot;The data at DIN is latched on the rising edg=
e<br>
&gt; of SCLK&quot;. Same to DOUT.<br>
&gt;<br>
&gt; This patch add Master Sample Data Mode bit in normal sample mode.<br>
&gt;<br>
&gt; Signed-off-by: Vinicius Maciel &lt;<a href=3D"mailto:viniciusfre@gmail=
.com">viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/spi/spi-sun4i.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c<br>
&gt; index c5cd635c28f3..6325be2ce8d9 100644<br>
&gt; --- a/drivers/spi/spi-sun4i.c<br>
&gt; +++ b/drivers/spi/spi-sun4i.c<br>
&gt; @@ -44,6 +44,7 @@<br>
&gt;=C2=A0 #define SUN4I_CTL_CS_MANUAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(16)<br>
&gt;=C2=A0 #define SUN4I_CTL_CS_LEVEL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(17)<br>
&gt;=C2=A0 #define SUN4I_CTL_TP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(18)<br>
&gt; +#define SUN4I_CTL_SDM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(20)<br>
&gt;<br>
&gt;=C2=A0 #define SUN4I_INT_CTL_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0c<br>
&gt;=C2=A0 #define SUN4I_INT_CTL_RF_F34=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(4)<br>
&gt; @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(<wbr>struct de=
vice *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sun4i_spi_write(sspi, SUN4I_CTL_REG,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0SUN4I_CTL_SDM);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
<br>
Thanks! That&#39;s a good catch. This particular bit is actually set in the=
<br>
reset default register value, according to the Allwinner A20 manual.<br>
But on Allwinner A10 and Allwinner A13 it is documented as unused and<br>
can&#39;t be changed (it remains zero even if we try to modify it).<br>
<br>
So looks like only A20 is affected, because the kernel currently sets a<br>
non-standard mode, deviating from both Allwinner&#39;s default and normal<b=
r>
SPI behaviour.<br>
<br>
You still need to update the summary line to add all the necessary<br>
sunxi and spi specific prefixes (see similar commits). Also a similar<br>
fix most likely needs to be applied to the spi-sun6i.c file too (due<br>
to the copy-paste curse and code duplication), but I&#39;m not sure if it<b=
r>
needs to be a part of this patch or a separate one.<br>
<br>
Reviewed-by: Siarhei Siamashka &lt;<a href=3D"mailto:siarhei.siamashka@gmai=
l.com">siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<br>
--<br>
Best regards,<br>
Siarhei Siamashka<br>
</blockquote></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--001a1141ddd263f6f40548387d21--
