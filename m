From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Add support for slave controllers
	plus sysfs entries for power management
Date: Tue, 16 Feb 2010 15:07:28 -0700
Message-ID: <fa686aa41002161407o267b34cg3890282365956d3a@mail.gmail.com>
References: <1261170416.10785.5.camel@ubuntu-vmware>
	<fa686aa41001190759j1d916f87o309efe37b3e96bf4@mail.gmail.com>
	<63386a3d1002141520p7cf33256vd8d6f7c23f61b0fe@mail.gmail.com>
	<1b68c6791002141737l6211c88dy79c762a3761cc93c@mail.gmail.com>
	<63386a3d1002161133k501e51f4xf4e94a307cb4fcf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <63386a3d1002161133k501e51f4xf4e94a307cb4fcf5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 16, 2010 at 12:33 PM, Linus Walleij
<linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 2010/2/15 jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
>> I don't think adding SPI_SLAVE support is just a matter of providing
>> additional callbacks and structures, as is pointed out in this thread....
>> http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg00368.html
>
> You mean that the responsiveness / control of latencies is the other thing
> that's needed? Yep so it is. But getting the infrastructure in place doesn't
> hurt because this is something many people (including self) need and Ken
> over at Intel is the only one actually doing something about it.

No, the model needs to be in place first.  That means describing the
model for spi_slave transfers.  Does the driver need to turn around
and respond mid-transfer?  Does there need to be latency controls?
How are protocol drivers interfaced with spi slave controllers (1 to
1, or 1 to many, how is the protocol selected)?

I appreciate the work Ken is doing, but the patches posted so far
abuse the spi_master model in a way I'm not willing to merge.  I think
spi_slave is a different enough thing that it warrants an entirely
different core infrastructure (but I do reserve the right to have my
mind changed).

> Getting SPI slaves to actually work by spawning their worker threads as
> realtime under that patchset is of course a larger issue. One does not
> exclude the other tho.

Your right, the realtime issues are separate, but I still need to see
how spi_slave devices are intended to work, and what the
strengths/limitations of the model are.

g.

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
