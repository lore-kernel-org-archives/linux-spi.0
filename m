From: "=?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=" <caronteycerbero-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: MMC/SD, SPI and IXP4XX
Date: Fri, 8 Aug 2008 17:20:42 +0200
Message-ID: <df996e0c0808080820m4ecaf7e3o7b140e70edd3ee6c@mail.gmail.com>
References: <df996e0c0808080211y2fb14c6dy10b02b3855134d46@mail.gmail.com>
	<55147.216.207.242.34.1218196029.squirrel@www.texascellnet.com>
	<df996e0c0808080614g27b4eafaha073eb714b7f344a@mail.gmail.com>
	<6927.216.207.242.34.1218202757.squirrel@www.texascellnet.com>
	<df996e0c0808080737i22cf6a8dx7085457aed02e449@mail.gmail.com>
	<16987.216.207.242.34.1218206865.squirrel@www.texascellnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1241235554=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <16987.216.207.242.34.1218206865.squirrel-9hn5j+WQJqK63hpG0/mJ51aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============1241235554==
Content-Type: multipart/alternative;
	boundary="----=_Part_29682_26421943.1218208842191"

------=_Part_29682_26421943.1218208842191
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Oooppps... It seems that I have been replying to Kbb instead of the list.
Let me send this mail with previous ones attached so that it can be useful
to anyone in my situation.

Hi Kbb

Perhaps I am not explaining myself correctly due to my English. My default
platform setup (which is arc/arm/mach-ixp4xx/ixdp425-setup.c), does not see=
m
to register a platform driver for SSP (not even in 2.6.26). That is why I
suppose that:

- No one has ever work in Linux with an IXP4XX and SSP.
- The work has not been submitted to the kernel.

As it seems there is not a platform driver for SSP in IXP4XX, I am trying t=
o
figure how to build one (and of course, connect it to mmc_spi as you have
suggested me). I could have tried to build it from scratch, but I found tha=
t
pxa2xx_spi was quite similar to what I tried to do, and that is why I am
asking this mailing list if this is the correct way to do this.

Thanks again for your answer and time.

Miguel =C1ngel


On Fri, Aug 8, 2008 at 4:47 PM, <kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org> wrote:

> No I am not familiar with the ixp465.  Look in the init file discussed
> earlier and look for the platform driver with SSP use.  Verify the resour=
ce
> addresses.
>
> open the mmc_spi and make sure it can connect to the last step.  and then
> go from there.
>
> Good luck.
>
> Kbb
>
>
> > Hi
> >
> > I see... Ok... I will have to figure if I can backport mmc_spi to
> 2.6.18.
> > So
> > mmc_spi is somekind of "protocol driver"?
> >
> > Thanks for your answers... Are you familiar with ixp4xx? I cannot see a=
n
> > driver for the host SPI so I am trying to port the one of pxa2xx. Do yo=
u
> > know if this is the best alternative?
> >
> > Things start to be more clear (or more dark, because it seems there is
> > quite
> > a lot of code to rewrite...)
> >
> > Miguel =C1ngel
> >
> >
> > On Fri, Aug 8, 2008 at 3:39 PM, <kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org> wrote:
> >
> >> You are right it does not support direct MMC.
> >>
> >> First enable the mmc_spi choice and the spi in the config file.
> >>
> >> I then had to go into the init file "/arch/arm/mach-???/????" that you=
r
> >> system is using and fix the platform driver so that it recognizes the
> >> hardware attached. This then should give you the use of the mmc_spi
> >> driver.
> >>
> >> Kbb
> >>
> >>
> >> > Hi Kbb
> >> >
> >> > Thanks for your answer.
> >> >
> >> > As far as I know, IXP465 has not an MMC/SD port. That is why I think=
 I
> >> > must
> >> > use the SPI port.
> >> >
> >> > Am I wrong?
> >> >
> >> > Miguel =C1ngel
> >> >
> >> > On Fri, Aug 8, 2008 at 1:47 PM, <kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org> wrote:
> >> >
> >> >> How is your hardware attached? Is it only through the MMC/SD port?
> >> >>
> >> >> If so then you do not really need the MMC over SPI, just the pxamci
> >> >> driver.
> >> >>
> >> >> Kbb
> >> >>
> >> >>
> >> >>
> >> >> > Hi.
> >> >> >
> >> >> > Some days ago I have sent a mail about using an SD card through S=
PI
> >> in
> >> >> an
> >> >> > IXP4XX system.
> >> >> >
> >> >> > Let me ask again for some help.
> >> >> > - I have seen pxa2xx_spi driver, and as it seems quite interestin=
g
> >> for
> >> >> me,
> >> >> > I
> >> >> > have beginned to port it to my platform. I attach the preliminary
> >> >> patch,
> >> >> > just in case it is useful for somebody... It is not tested yet,
> >> >> however.
> >> >> > - To test it I am trying to read information about using an SD
> >> card,
> >> >> but
> >> >> I
> >> >> > am quite confussed by now... It seems there is some kind of mmc_s=
pi
> >> >> driver
> >> >> > in latest kernels, but I do not know how all the pieces oz the
> >> puzzle
> >> >> mach
> >> >> > together. Any help would be appreciated.
> >> >> >
> >> >> > In my case I am using kernel 2.6.18 (trying to migrate to newer
> >> >> releases,
> >> >> > but not quite successfull yet), but if the help comes "explaining
> >> the
> >> >> > concept" in 2.6.24 or other kernels, it will also be quite useful=
.
> >> >> >
> >> >> > Thanks a lot.
> >> >> >
> >> >> > Miguel =C1ngel =C1lvarez
> >> >> >
> >>
> -------------------------------------------------------------------------
> >> >> > This SF.Net email is sponsored by the Moblin Your Move Developer'=
s
> >> >> > challenge
> >> >> > Build the coolest Linux based applications with Moblin SDK & win
> >> great
> >> >> > prizes
> >> >> > Grand prize is a trip for two to an Open Source event anywhere in
> >> the
> >> >> > world
> >> >> >
> >> >>
> >>
> http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/___________=
____________________________________
> >> >> > spi-devel-general mailing list
> >> >> > spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> >> > https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> >> >> >
> >> >
> >>
> >
>

------=_Part_29682_26421943.1218208842191
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div dir=3D"ltr">Oooppps... It seems that I have been replying to Kbb inste=
ad of the list. Let me send this mail with previous ones attached so that i=
t can be useful to anyone in my situation.<br><br>Hi Kbb<br>
<br>Perhaps I am not explaining myself correctly due to my English. My defa=
ult platform setup (which is arc/arm/mach-ixp4xx/ixdp425-setup.c), does not=
 seem to register a platform driver for SSP (not even in 2.6.26). That is w=
hy I suppose that:<br>
<br>- No one has ever work in Linux with an IXP4XX and SSP.<br>- The work h=
as not been submitted to the kernel.<br><br>As it seems there is not a plat=
form driver for SSP in IXP4XX, I am trying to figure how to build one (and =
of course, connect it to mmc_spi as you have suggested me). I could have tr=
ied to build it from scratch, but I found that pxa2xx_spi was quite similar=
 to what I tried to do, and that is why I am asking this mailing list if th=
is is the correct way to do this.<br>
<br>Thanks again for your answer and time.<br>
<br>Miguel =C1ngel<br><br><br><div class=3D"gmail_quote">On Fri, Aug 8, 200=
8 at 4:47 PM,  <span dir=3D"ltr">&lt;<a href=3D"mailto:kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org=
">kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
No I am not familiar with the ixp465.&nbsp; Look in the init file
discussed earlier and look for the platform driver with SSP use.&nbsp;
Verify the resource addresses.<br><br>open the mmc_spi and make sure
it can connect to the last step.&nbsp; and then go from there.<br><br>Good =
luck.<br><br>Kbb<div><div></div><div class=3D"Wj3C7c"><br><br>&gt; Hi<br>&g=
t; <br>&gt; I
see... Ok... I will have to figure if I can backport mmc_spi to <a href=3D"=
http://2.6.18." target=3D"_blank">2.6.18.</a><br>&gt; So<br>&gt; mmc_spi is=
 somekind of &quot;protocol driver&quot;?<br>&gt; <br>&gt; Thanks for your =
answers... Are you familiar with ixp4xx?
I cannot see an<br>&gt; driver for the host SPI so I am trying to port
the one of pxa2xx. Do you<br>&gt; know if this is the best
alternative?<br>&gt; <br>&gt; Things start to be more clear (or more
dark, because it seems there is<br>&gt; quite<br>&gt; a lot of code to
rewrite...)<br>&gt; <br>&gt; Miguel =C1ngel<br>&gt; <br>&gt;
<br>&gt; On Fri, Aug 8, 2008 at 3:39 PM, &lt;<a href=3D"mailto:kbb@texascel=
lnet.com" target=3D"_blank">kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org</a>&gt;
wrote:<br>&gt; <br>&gt;&gt; You are right  it does not  support direct
MMC.<br>&gt;&gt;<br>&gt;&gt; First enable the mmc_spi choice and the
spi in the config file.<br>&gt;&gt;<br>&gt;&gt; I then had to go into
the init file &quot;/arch/arm/mach-???/????&quot; that your<br>&gt;&gt;
system is using and fix the platform driver so that it recognizes the<br>&g=
t;&gt; hardware attached.  This then should give you the use of the
mmc_spi<br>&gt;&gt; driver.<br>&gt;&gt;<br>&gt;&gt; Kbb<br>&gt;&gt;<br>&gt;=
&gt;<br>&gt;&gt; &gt; Hi Kbb<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Thanks for y=
our answer.<br>&gt;&gt; &gt;<br>&gt;&gt;
&gt; As far as I know, IXP465 has not an MMC/SD port. That is why I think
I<br>&gt;&gt; &gt; must<br>&gt;&gt; &gt; use the SPI port.<br>&gt;&gt; &gt;=
<br>&gt;&gt; &gt; Am I wrong?<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Miguel =C1n=
gel<br>&gt;&gt; &gt;<br>&gt;&gt; &gt;
On Fri, Aug 8, 2008 at 1:47 PM, &lt;<a href=3D"mailto:kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org"=
 target=3D"_blank">kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org</a>&gt; wrote:<br>&gt;&gt; &gt;<br>=
&gt;&gt; &gt;&gt; How is your hardware attached? Is
it only through the MMC/SD port?<br>&gt;&gt; &gt;&gt;<br>&gt;&gt;
&gt;&gt; If so then you do not really need the MMC over SPI, just the
pxamci<br>&gt;&gt; &gt;&gt; driver.<br>&gt;&gt; &gt;&gt;<br>&gt;&gt;
&gt;&gt; Kbb<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt;<br>&gt;&gt;
&gt;&gt;<br>&gt;&gt; &gt;&gt; &gt; Hi.<br>&gt;&gt; &gt;&gt; &gt;<br>&gt;&gt=
; &gt;&gt; &gt; Some days ago I have sent a mail about using an
SD card through SPI<br>&gt;&gt; in<br>&gt;&gt; &gt;&gt; an<br>&gt;&gt; &gt;=
&gt; &gt; IXP4XX system.<br>&gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &gt=
; Let me ask again for some help.<br>&gt;&gt;
&gt;&gt; &gt; - I have seen pxa2xx_spi driver, and as it seems quite
interesting<br>&gt;&gt; for<br>&gt;&gt; &gt;&gt; me,<br>&gt;&gt;
&gt;&gt; &gt; I<br>&gt;&gt; &gt;&gt; &gt; have beginned to port it to my
platform. I attach the preliminary<br>&gt;&gt; &gt;&gt; patch,<br>&gt;&gt; =
&gt;&gt; &gt; just in case it is useful for somebody... It is
not tested yet,<br>&gt;&gt; &gt;&gt; however.<br>&gt;&gt; &gt;&gt;
&gt; - To test it I am trying to read information about using an SD<br>&gt;=
&gt; card,<br>&gt;&gt; &gt;&gt; but<br>&gt;&gt; &gt;&gt; I<br>&gt;&gt; &gt;=
&gt; &gt; am quite confussed by now... It seems there is
some kind of mmc_spi<br>&gt;&gt; &gt;&gt; driver<br>&gt;&gt; &gt;&gt;
&gt; in latest kernels, but I do not know how all the pieces oz the<br>&gt;=
&gt; puzzle<br>&gt;&gt; &gt;&gt; mach<br>&gt;&gt; &gt;&gt; &gt;
together. Any help would be appreciated.<br>&gt;&gt; &gt;&gt; &gt;<br>&gt;&=
gt; &gt;&gt; &gt; In my case I am using kernel 2.6.18 (trying to
migrate to newer<br>&gt;&gt; &gt;&gt; releases,<br>&gt;&gt; &gt;&gt;
&gt; but not quite successfull yet), but if the help comes
&quot;explaining<br>&gt;&gt; the<br>&gt;&gt; &gt;&gt; &gt;
concept&quot; in 2.6.24 or other kernels, it will also be quite useful.<br>=
&gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &gt; Thanks a lot.<br>&gt;&gt; =
&gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &gt; Miguel =C1ngel
=C1lvarez<br>&gt;&gt; &gt;&gt; &gt;<br>&gt;&gt;
-------------------------------------------------------------------------<b=
r>&gt;&gt; &gt;&gt; &gt; This SF.Net email is sponsored by the Moblin Your
Move Developer&#39;s<br>&gt;&gt; &gt;&gt; &gt; challenge<br>&gt;&gt;
&gt;&gt; &gt; Build the coolest Linux based applications with Moblin SDK
&amp; win<br>&gt;&gt; great<br>&gt;&gt; &gt;&gt; &gt; prizes<br>&gt;&gt; &g=
t;&gt; &gt; Grand prize is a trip for two to an Open Source
event anywhere in<br>&gt;&gt; the<br>&gt;&gt; &gt;&gt; &gt; world<br>&gt;&g=
t; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt;<br>&gt;&gt;
<a href=3D"http://moblin-contest.org/redirect.php?banner_id=3D100&amp;url=
=3D/_______________________________________________" target=3D"_blank">http=
://moblin-contest.org/redirect.php?banner_id=3D100&amp;url=3D/_____________=
__________________________________</a><br>
&gt;&gt; &gt;&gt; &gt; spi-devel-general mailing list<br>&gt;&gt;
&gt;&gt; &gt; <a href=3D"mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" ta=
rget=3D"_blank">spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org</a><br>&gt;&gt;
&gt;&gt; &gt;
<a href=3D"https://lists.sourceforge.net/lists/listinfo/spi-devel-general" =
target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/spi-devel-ge=
neral</a><br>&gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;<br>&gt;&gt;<br>&gt;</d=
iv>
</div></blockquote></div><br></div>

------=_Part_29682_26421943.1218208842191--


--===============1241235554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1241235554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1241235554==--
