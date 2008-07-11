From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Re: Problems with latency
Date: Fri, 11 Jul 2008 11:39:26 +1000
Message-ID: <33e9dd1c0807101839o4ccb52bcr5adb664175d59e68@mail.gmail.com>
References: <33e9dd1c0806242302y4e39b869n4a64f4955cc71dd5@mail.gmail.com>
	<4874C9A6.8020009@whoi.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1656736841=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4874C9A6.8020009-/d+BM93fTQY@public.gmane.org>
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

--===============1656736841==
Content-Type: multipart/alternative;
	boundary="----=_Part_23919_13163676.1215740366498"

------=_Part_23919_13163676.1215740366498
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Ned, I finally found the solution to my problem. It turned out that
the problem was in fact nothing to do with the receive side of the system
where the FIFO overflows were occurring. The problem was that the standard
linux tty driver was very aggressively calling a transmit flush on every
single character sent. This works well when your serial chip is connected
directly on the processor bus but turns out to be quite a bad thing when
your serial chip is connected via SPI.

The very large number of SPI transmits was causing a huge amount of
interrupt activity, which was in turn occasionally causing delays in getting
to the receive side work queue. These delays were long enough that the
receive FIFO would overflow and it was all bad from there.

I'm not sure what changed between 2.6.16 and 2.6.24 which made this become a
critical problem - quite possibly something subtle could have had this
side-effect. I solved the problem by aggregating the transmit characters and
sending them in larger groups. This seems to have fixed the problem.

Thanks for your follow-up,
Zik

On Thu, Jul 10, 2008 at 12:22 AM, Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> wrote:

> Zik Saleeba wrote:
> > I'm writing a driver for the NXP sc16is752 serial chip. This chip is
> > accessed via SPI. I've actually had a working driver for quite some time
> now
> > but I've been having problems with it since I changed from 2.6.16 to
> > 2.6.24.Occasionally the driver fails due to its 64 byte receive buffer
> > overflowing
> > before I can get the data.
> >
> > I've set the serial chip's receive buffer interrupt level to 16 bytes -
> so
> > after I've received 16 bytes I have to get the data before the buffer
> > overflows its 64 byte limit. This isn't too demanding - I need to have it
> > done within 8ms of getting the interrupt at 57600bps. The tricky part is
> > that I need to do three separate register reads to get status before I
> can
> > do the final buffer read so it's actually four SPI transactions. And
> what's
> > more the chip has two serial ports so I need to check both - which makes
> it
> > up to eight SPI transactions.
> >
> > Normally this is absolutely no problem - the bottom half work queue fires
> up
> > and the SPI subsystem on my pxa2xx romps it in. Once in a while however
> the
> > latency between the interrupt and removing the data is much, much longer
> and
> > the chip's receive buffer overflows. This happens enough that it makes
> the
> > driver unusable at higher bit rates.
> >
> > Does anyone have any suggestions what might be causing these random
> latency
> > jumps, and also whether it might be related to work queue latency or to
> > pxa2xx spi delays?
>
> Perhaps you have found a solution by now.  I have been away.
>
> The only suggestion I have is a general one, not specifically related to
> the driver.  In my application, I read from an SPI device at 11MBit/sec,
> and write the data to an NFS server elsewhere on the network.  I found
> that if I did not do frequent fdatasync() calls on the NFS file from my
> user-space code, then Linux would simply queue huge amounts of data in
> the PXA255's 64MB RAM, and would not actually write to the network until
> the RAM was nearly full.  When it did finally write to the network,
> there were huge latencies (nearly a second) in interrupt service to the
> SPI.  By forcing it to write in smaller chunks, the latency problem
> disappeared.  I have no idea whether this could be related to your problem.
>
> --
> Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
> Oceanographic Systems Lab                                  508-289-2226
> Applied Ocean Physics and Engineering Dept.
> Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
> http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
> http://www.whoi.edu/hpb/Site.do?id=1532
> http://www.whoi.edu/page.do?pid=10079
>
>

------=_Part_23919_13163676.1215740366498
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Ned, I finally found the solution to my problem. It turned out that the problem was in fact nothing to do with the receive side of the system where the FIFO overflows were occurring. The problem was that the standard linux tty driver was very aggressively calling a transmit flush on every single character sent. This works well when your serial chip is connected directly on the processor bus but turns out to be quite a bad thing when your serial chip is connected via SPI.<br>
<br>The very large number of SPI transmits was causing a huge amount of interrupt activity, which was in turn occasionally causing delays in getting to the receive side work queue. These delays were long enough that the receive FIFO would overflow and it was all bad from there.<br>
<br>I&#39;m not sure what changed between 2.6.16 and 2.6.24 which made this become a critical problem - quite possibly something subtle could have had this side-effect. I solved the problem by aggregating the transmit characters and sending them in larger groups. This seems to have fixed the problem.<br>
<br>Thanks for your follow-up,<br>Zik<br><br><div class="gmail_quote">On Thu, Jul 10, 2008 at 12:22 AM, Ned Forrester &lt;<a href="mailto:nforrester-/d+BM93fTQY@public.gmane.org">nforrester-/d+BM93fTQY@public.gmane.org</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">Zik Saleeba wrote:<br>
&gt; I&#39;m writing a driver for the NXP sc16is752 serial chip. This chip is<br>
&gt; accessed via SPI. I&#39;ve actually had a working driver for quite some time now<br>
&gt; but I&#39;ve been having problems with it since I changed from 2.6.16 to<br>
&gt; 2.6.24.Occasionally the driver fails due to its 64 byte receive buffer<br>
&gt; overflowing<br>
&gt; before I can get the data.<br>
&gt;<br>
&gt; I&#39;ve set the serial chip&#39;s receive buffer interrupt level to 16 bytes - so<br>
&gt; after I&#39;ve received 16 bytes I have to get the data before the buffer<br>
&gt; overflows its 64 byte limit. This isn&#39;t too demanding - I need to have it<br>
&gt; done within 8ms of getting the interrupt at 57600bps. The tricky part is<br>
&gt; that I need to do three separate register reads to get status before I can<br>
&gt; do the final buffer read so it&#39;s actually four SPI transactions. And what&#39;s<br>
&gt; more the chip has two serial ports so I need to check both - which makes it<br>
&gt; up to eight SPI transactions.<br>
&gt;<br>
&gt; Normally this is absolutely no problem - the bottom half work queue fires up<br>
&gt; and the SPI subsystem on my pxa2xx romps it in. Once in a while however the<br>
&gt; latency between the interrupt and removing the data is much, much longer and<br>
&gt; the chip&#39;s receive buffer overflows. This happens enough that it makes the<br>
&gt; driver unusable at higher bit rates.<br>
&gt;<br>
&gt; Does anyone have any suggestions what might be causing these random latency<br>
&gt; jumps, and also whether it might be related to work queue latency or to<br>
&gt; pxa2xx spi delays?<br>
<br>
</div></div>Perhaps you have found a solution by now. &nbsp;I have been away.<br>
<br>
The only suggestion I have is a general one, not specifically related to<br>
the driver. &nbsp;In my application, I read from an SPI device at 11MBit/sec,<br>
and write the data to an NFS server elsewhere on the network. &nbsp;I found<br>
that if I did not do frequent fdatasync() calls on the NFS file from my<br>
user-space code, then Linux would simply queue huge amounts of data in<br>
the PXA255&#39;s 64MB RAM, and would not actually write to the network until<br>
the RAM was nearly full. &nbsp;When it did finally write to the network,<br>
there were huge latencies (nearly a second) in interrupt service to the<br>
SPI. &nbsp;By forcing it to write in smaller chunks, the latency problem<br>
disappeared. &nbsp;I have no idea whether this could be related to your problem.<br>
<font color="#888888"><br>
--<br>
Ned Forrester &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="mailto:nforrester-/d+BM93fTQY@public.gmane.org">nforrester-/d+BM93fTQY@public.gmane.org</a><br>
Oceanographic Systems Lab &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;508-289-2226<br>
Applied Ocean Physics and Engineering Dept.<br>
Woods Hole Oceanographic Institution &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Woods Hole, MA 02543, USA<br>
<a href="http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212" target="_blank">http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212</a><br>
<a href="http://www.whoi.edu/hpb/Site.do?id=1532" target="_blank">http://www.whoi.edu/hpb/Site.do?id=1532</a><br>
<a href="http://www.whoi.edu/page.do?pid=10079" target="_blank">http://www.whoi.edu/page.do?pid=10079</a><br>
<br>
</font></blockquote></div><br>

------=_Part_23919_13163676.1215740366498--


--===============1656736841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============1656736841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1656736841==--
