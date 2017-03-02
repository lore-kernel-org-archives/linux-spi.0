From: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data
 Mode for SPI
Date: Thu, 2 Mar 2017 14:00:03 -0800 (PST)
Message-ID: <dcd87d04-7b53-4d23-8918-359f2b327a53@googlegroups.com>
References: <20170211035447.3819-1-viniciusfre@gmail.com>
 <20170213125239.f5vsxrfwz5t6gqyp@sirena.org.uk>
 <186c0f31-01d0-4a1b-889b-a390a57bd1d9@googlegroups.com>
 <20170302224410.31dea7a9@i7>
Reply-To: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_56_918911908.1488492003732"
Cc: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Return-path: <linux-sunxi+bncBDNJJSMB6QFRBZFL4LCQKGQE572ZG2A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170302224410.31dea7a9@i7>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

------=_Part_56_918911908.1488492003732
Content-Type: multipart/alternative;
	boundary="----=_Part_57_440743883.1488492003732"

------=_Part_57_440743883.1488492003732
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Em quinta-feira, 2 de mar=C3=A7o de 2017 17:44:16 UTC-3, Siarhei Siamashka=
=20
escreveu:

> Here is a short summary. Older Allwinner A10/A13 SoCs used to have=20
> reserved RAZ/WI (Read-As-Zero, Writes Ignored) bits 20-31 in the=20
> SPI_CTL register. Newer Allwinner A20 SoC introduced some sort of=20
> a wacky half-cycle delay mode and used the previously reserved bit=20
> 20 from the SPI_CTL to enable/disable it. Now the tricky part is that=20
> the meaning of this new bit is inverted for some unknown reason: the=20
> wacky mode is activated when the bit is set to zero, while the standard=
=20
> behaviour (same as A10/A13) is preserved when this bit is set to 1. The=
=20
> reset default of this bit is 1 on A20 (normal SPI behaviour). The=20
> problem of the current SPI driver is that it clears bits 20-31 of=20
> SPI_CTL, which results in normal SPI behaviour on A10/A13, and a wacky=20
> half-cycle delayed mode on A20. Your bugfix just makes A20 behave in=20
> the same way as A10/A13.=20

These are the exact words I was looking for, thanks Siarhei.=20
And I don't really know which chip could to use this wacky half-cycle=20
delay mode. Anyway, maybe a new dts property could be a solution to=20
let user to enable or not normal mode and half-cycle mode?

Best regards,
Vinicius

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_57_440743883.1488492003732
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>Em quinta-feira, 2 de mar=C3=A7o de 2017 17:44:16 =
UTC-3, Siarhei Siamashka  escreveu:<div><br></div><div>&gt; Here is a short=
 summary. Older Allwinner A10/A13 SoCs used to have=C2=A0</div><div>&gt; re=
served RAZ/WI (Read-As-Zero, Writes Ignored) bits 20-31 in the=C2=A0<br>&gt=
; SPI_CTL register. Newer Allwinner A20 SoC introduced some sort of=C2=A0<b=
r>&gt; a wacky half-cycle delay mode and used the previously reserved bit=
=C2=A0<br>&gt; 20 from the SPI_CTL to enable/disable it. Now the tricky par=
t is that=C2=A0<br>&gt; the meaning of this new bit is inverted for some un=
known reason: the=C2=A0<br>&gt;=C2=A0wacky mode is activated when the bit i=
s set to zero, while the standard=C2=A0<br>&gt;=C2=A0behaviour (same as A10=
/A13) is preserved when this bit is set to 1. The=C2=A0<br>&gt;=C2=A0reset =
default of this bit is 1 on A20 (normal SPI behaviour). The=C2=A0<br>&gt;=
=C2=A0problem of the current SPI driver is that it clears bits 20-31 of=C2=
=A0<br>&gt;=C2=A0SPI_CTL, which results in normal SPI behaviour on A10/A13,=
 and a wacky=C2=A0<br>&gt;=C2=A0half-cycle delayed mode on A20. Your bugfix=
 just makes A20 behave in=C2=A0<br>&gt;=C2=A0the same way as A10/A13.=C2=A0=
<br></div><div><br></div><div><div>These are the exact words I was looking =
for, thanks Siarhei.=C2=A0</div><div>And I don&#39;t really know which chip=
 could to use this wacky half-cycle=C2=A0</div><div>delay mode. Anyway, may=
be a new dts property could be a solution to=C2=A0</div><div>let user to en=
able or not normal mode and half-cycle mode?</div></div><div><br></div><div=
>Best regards,</div><div>Vinicius</div><div><br></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_57_440743883.1488492003732--

------=_Part_56_918911908.1488492003732--
