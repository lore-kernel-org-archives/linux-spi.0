From: "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Tue, 28 Apr 2015 07:03:16 -0700 (PDT)
Message-ID: <28a25eda-bba0-4a2e-9890-b3d3bef7ac7e@googlegroups.com>
References: <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
 <20150426103257.GJ22845@sirena.org.uk> <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk> <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org> <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather> <20150427101601.GN22845@sirena.org.uk>
 <20150427173036.GA10950@lukather> <20150427180728.GW22845@sirena.org.uk> <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com>
 <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
Reply-To: eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_177_1820703786.1430229796840"
Cc: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDD6NW6IFYIKLJX6VECRUBCJH6KJW-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

------=_Part_177_1820703786.1430229796840
Content-Type: multipart/alternative;
	boundary="----=_Part_178_1074045199.1430229796840"

------=_Part_178_1074045199.1430229796840
Content-Type: text/plain; charset=UTF-8

Hi,

I give Maxime's patch a try and got 4 spidev devices : 
/dev/spidev32766.[0-3]

root@bpi:~# ls -lh /dev/spidev*
crw------- 1 root root 153, 0 Apr 28 15:52 /dev/spidev32766.0
crw------- 1 root root 153, 1 Apr 28 15:52 /dev/spidev32766.1
crw------- 1 root root 153, 2 Apr 28 15:52 /dev/spidev32766.2
crw------- 1 root root 153, 3 Apr 28 15:52 /dev/spidev32766.3

Shouldn't they be numbered from like spidev0.[0-3].
Is this an udev problem ? any clues ?

For now I will try with this devices.

Thanks a lot,
Eric

On Tuesday, April 28, 2015 at 2:53:37 PM UTC+2, Michal Suchanek wrote:
>
> On 28 April 2015 at 14:15, Eric D. <eric.d...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:>> 
> wrote: 
> > Hi, 
> > 
> > I'am a mainline linux user of A20 (bananapi). I'am currently running a 
> > debian jessie with latest mainline kernel (4.0.0+). 
> > I have a project of home automation, based on nrfl04+ spi driven 
> wireless 
> > chip. 
> > I was just seeking a way to make spidev device appear under mainline 
> kernel 
> > and found this thread. 
> > Could someone explain the right way to do this ? 
>
> There is no approved RightWay(tm). 
>
> However, you can use this patch: 
>
> https://lkml.org/lkml/2014/4/28/612 
>
> which is probably the least controversial way for now. 
>
> The example at the start of the thread also works but is 
> CertainlyNotApprovedWay(tm). 
>
> HTH 
>
> Michal 
>

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_178_1074045199.1430229796840
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I give Maxime's patch a try and got 4 spidev de=
vices : /dev/spidev32766.[0-3]<br><br>root@bpi:~# ls -lh /dev/spidev*<br>cr=
w------- 1 root root 153, 0 Apr 28 15:52 /dev/spidev32766.0<br>crw------- 1=
 root root 153, 1 Apr 28 15:52 /dev/spidev32766.1<br>crw------- 1 root root=
 153, 2 Apr 28 15:52 /dev/spidev32766.2<br>crw------- 1 root root 153, 3 Ap=
r 28 15:52 /dev/spidev32766.3<br><br>Shouldn't they be numbered from like s=
pidev0.[0-3].<br>Is this an udev problem ? any clues ?<br><br>For now I wil=
l try with this devices.<br><br>Thanks a lot,<br>Eric<br><br>On Tuesday, Ap=
ril 28, 2015 at 2:53:37 PM UTC+2, Michal Suchanek wrote:<blockquote class=
=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #cc=
c solid;padding-left: 1ex;">On 28 April 2015 at 14:15, Eric D. &lt;<a href=
=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"Jd0JfD_cMlUJ" r=
el=3D"nofollow" onmousedown=3D"this.href=3D'javascript:';return true;" oncl=
ick=3D"this.href=3D'javascript:';return true;">eric.d...-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:
<br>&gt; Hi,
<br>&gt;
<br>&gt; I'am a mainline linux user of A20 (bananapi). I'am currently runni=
ng a
<br>&gt; debian jessie with latest mainline kernel (4.0.0+).
<br>&gt; I have a project of home automation, based on nrfl04+ spi driven w=
ireless
<br>&gt; chip.
<br>&gt; I was just seeking a way to make spidev device appear under mainli=
ne kernel
<br>&gt; and found this thread.
<br>&gt; Could someone explain the right way to do this ?
<br>
<br>There is no approved RightWay(tm).
<br>
<br>However, you can use this patch:
<br>
<br><a href=3D"https://lkml.org/lkml/2014/4/28/612" target=3D"_blank" rel=
=3D"nofollow" onmousedown=3D"this.href=3D'https://www.google.com/url?q\75ht=
tps%3A%2F%2Flkml.org%2Flkml%2F2014%2F4%2F28%2F612\46sa\75D\46sntz\0751\46us=
g\75AFQjCNEuu363kO_AZz9vl5R_-uZ3JfjOzw';return true;" onclick=3D"this.href=
=3D'https://www.google.com/url?q\75https%3A%2F%2Flkml.org%2Flkml%2F2014%2F4=
%2F28%2F612\46sa\75D\46sntz\0751\46usg\75AFQjCNEuu363kO_AZz9vl5R_-uZ3JfjOzw=
';return true;">https://lkml.org/lkml/2014/4/<wbr>28/612</a>
<br>
<br>which is probably the least controversial way for now.
<br>
<br>The example at the start of the thread also works but is
<br>CertainlyNotApprovedWay(tm).
<br>
<br>HTH
<br>
<br>Michal
<br></blockquote></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_178_1074045199.1430229796840--

------=_Part_177_1820703786.1430229796840--
