From: "Hans Eklund" <herr.eklund-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] spi_mmc bus
	concurrency fix
Date: Tue, 25 Mar 2008 11:25:43 +0100
Message-ID: <27eff8270803250325q4442862etf25ae768661a3f19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1737980701=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

--===============1737980701==
Content-Type: multipart/alternative;
	boundary="----=_Part_17814_3860768.1206440743774"

------=_Part_17814_3860768.1206440743774
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again.

Lets move on.

I have not solved the roots to the problem. I=B4ve not been given time to
fiddle with the framework internals. Im not sure im the man to do that in
the end. But, I have managed to get MMC/SD cards running concurrently with
m25p80 spi flash driver. No fix to either the master driver or the
framework. Both reading and writing and card init works. No multiple block
writing yet though. All done vs uClinux 2008R1-RC8 (kernel 2.6.22) and my
old spi_mmc driver which implemented a separate block layer. Written and
tested mostly within the Blackfin uClinux community.

About the fix: In short i predefine a sequence of transfers in a single
message matching the MMC/SD protocol, simply assuming it will work, checkin=
g
the tokens and if tokens looked fine return with a smile. It seem to work.
It is the only way to get atomicity on the bus for now. It is surley best t=
o
patch up the drivers/mmc/host/mmc_spi.c code and use that driver from now
on, putting my old spi_mmc driver on the shelf.

Bryan, Mike and other Blackfin-uClinux developers:

What is the status on the drivers/mmc/host/mmc_spi.c when connected to the
Blackfin spi master? Mike pointed out that my old spi_mmc should be
obsoleted(with all rights), with that statement I got the feeling the "new"
mainline driver was tested to some extent, correct? I would need a
test/develop environment to move on with this. I=B4ll try to backport the
mmc_spi found in 2.6.24 to fit 2008R1-RC8 as a start, or do you have any
other suggestions?

I hope i get the attention of Jan Nikitenko and Hans-Peter Nilsson on this
subject also as they seem to have been a part of the mmc_spi driver
developing.

/regards
Hans Eklund,
Rubico AB,
Sweden.

David Brownell skrev:
> On Thursday 28 February 2008, Phil Wilshire wrote:
>> I agree, I did have some concerns about the callback issue.
>> It also looks like we have enough people + momentum on this problem to
>> get a fix in good time. So I'll wait to see what happens.
>
> Actually, I'm not sure I'd agree on that. Folk want a fix,
> but nobody (including me!) has sent something that's quite
> mergeable yet.
>
> I think part of the solution may be what someone (Brian?)
> observed: that growing the mid-layer to handle some of the
> queue management functions should help, no matter what
> eventual solution is adopted.
>
> That might be as little as providing a default "add to queue"
> and "take from queue" mechanism and starting to phase it into
> use in the various master controller drivers. When they use
> that scheme, it should be easy to splice in alternative queue
> management policies (notably: "only spi_mmc can access the
> bus for now") without changing the controller drivers.
>
> So it'd be really nice if someone could come up with a patch
> like that to help get some forward motion ... unless there's
> a better suggestion for how to move forward?
>
> - Dave
>
>

------=_Part_17814_3860768.1206440743774
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again.<br><br>Lets move on.<br><br>I have not solved the roots to the pr=
oblem. I=B4ve not been given time to fiddle with the framework internals. I=
m not sure im the man to do that in the end. But, I have managed to get MMC=
/SD cards running concurrently with m25p80 spi flash driver. No fix to eith=
er the master driver or the framework. Both reading and writing and card in=
it works. No multiple block writing yet though. All done vs uClinux 2008R1-=
RC8 (kernel 2.6.22) and my old spi_mmc driver which implemented a separate =
block layer. Written and tested mostly within the Blackfin uClinux communit=
y.<br>
<br>About the fix: In short i predefine a sequence of transfers in a single=
 message matching the MMC/SD protocol, simply assuming it will work, checki=
ng the tokens and if tokens looked fine return with a smile. It seem to wor=
k. It is the only way to get atomicity on the bus for now. It is surley bes=
t to patch up the drivers/mmc/host/mmc_spi.c code and use that driver from =
now on, putting my old spi_mmc driver on the shelf.<br>
<br>Bryan, Mike and other Blackfin-uClinux developers:<br><br>What is the s=
tatus on the drivers/mmc/host/mmc_spi.c when connected to the Blackfin spi =
master? Mike pointed out that my old spi_mmc should be obsoleted(with all r=
ights), with that statement I got the feeling the &quot;new&quot; mainline =
driver was tested to some extent, correct? I would need a test/develop envi=
ronment to move on with this. I=B4ll try to backport the mmc_spi found in 2=
.6.24 to fit 2008R1-RC8 as a start, or do you have any other suggestions?<b=
r>
<br>I hope i get the attention of Jan Nikitenko and Hans-Peter Nilsson on t=
his subject also as they seem to have been a part of the mmc_spi driver dev=
eloping.<br><br>/regards<br>Hans Eklund,<br>Rubico AB,<br>Sweden.<br><br>
David Brownell skrev:<br>&gt; On Thursday 28 February 2008, Phil Wilshire w=
rote:<br>&gt;&gt; I agree, I did have some concerns about the callback issu=
e.<br>&gt;&gt; It also looks like we have enough people + momentum on this =
problem to<br>
&gt;&gt; get a fix in good time. So I&#39;ll wait to see what happens.<br>&=
gt;<br>&gt; Actually, I&#39;m not sure I&#39;d agree on that.  Folk want a =
fix,<br>&gt; but nobody (including me!) has sent something that&#39;s quite=
<br>
&gt; mergeable yet.<br>&gt;<br>&gt; I think part of the solution may be wha=
t someone (Brian?)<br>&gt; observed:  that growing the mid-layer to handle =
some of the<br>&gt; queue management functions should help, no matter what<=
br>
&gt; eventual solution is adopted.<br>&gt;<br>&gt; That might be as little =
as providing a default &quot;add to queue&quot;<br>&gt; and &quot;take from=
 queue&quot; mechanism and starting to phase it into<br>&gt; use in the var=
ious master controller drivers.  When they use<br>
&gt; that scheme, it should be easy to splice in alternative queue<br>&gt; =
management policies (notably:  &quot;only spi_mmc can access the<br>&gt; bu=
s for now&quot;) without changing the controller drivers.<br>&gt;<br>&gt; S=
o it&#39;d be really nice if someone could come up with a patch<br>
&gt; like that to help get some forward motion ... unless there&#39;s<br>&g=
t; a better suggestion for how to move forward?<br>&gt;<br>&gt; - Dave<br>&=
gt;<br>&gt;<br><br><br><br>

------=_Part_17814_3860768.1206440743774--


--===============1737980701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1737980701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1737980701==--
