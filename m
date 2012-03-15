From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: bitbang: add PM QoS support
Date: Thu, 15 Mar 2012 17:57:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203151747480.2988@axis700.grange>
References: <Pine.LNX.4.64.1203141837170.30291@axis700.grange>
	<20120315092923.951203E04FD@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120315092923.951203E04FD@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 15 Mar 2012, Grant Likely wrote:

> On Wed, 14 Mar 2012 22:04:25 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > This patch adds a PM QoS requirement to the spi-bitbang driver, preventing
> > the underlying SPI hardware driver to suspend for too long a time, as long
> > as there are transfers on the queue.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> 
> Shouldn't this be part of the core spi infrastructure?  Particularly since queuing
> is moving into the core.

Maybe, can you point me out to commit IDs / subject lines / archive 
threads?

Anyway, this patch has to be reworked and extended. OTOH, if we 
universally agree, that no runtime-suspending of SPI controllers should 
take place with active CSs, it might happen, that we don't need this PM 
QoS at all - client drivers tend to hold CS lines for essentially longer 
periods of time, than what the SPI subsystem can recognise as a 
low-latency transfer sequence. The only example, that I can think of, 
where PM QoS could be useful is, if we have to keep latency low while 
communicating with different SPI devices on different chip-selects (like 
multiple audio-codecs, where their adjustment has to happen as 
synchronously as possible... No, I have no idea what I'm talking 
about:-)).

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
