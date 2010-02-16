From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] Add support for slave controllers
 plus sysfs entries for power management
Date: Tue, 16 Feb 2010 15:48:12 -0500
Message-ID: <4B7B048C.8080205@whoi.edu>
References: <1261170416.10785.5.camel@ubuntu-vmware>	<fa686aa41001190759j1d916f87o309efe37b3e96bf4@mail.gmail.com>	<63386a3d1002141520p7cf33256vd8d6f7c23f61b0fe@mail.gmail.com>	<1b68c6791002141737l6211c88dy79c762a3761cc93c@mail.gmail.com>
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

On 02/16/2010 02:33 PM, Linus Walleij wrote:
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
> 
> Getting SPI slaves to actually work by spawning their worker threads as
> realtime under that patchset is of course a larger issue. One does not
> exclude the other tho.

I'm a little fuzzy on what application you have in mind for this.  It
doesn't seem productive to lay in a layer of changes for slave operation
before knowing if it is possible to create a useful slave.  Putting the
infrastructure before determining feasibility seems the wrong way
around, especially since you wouldn't be sure what support to add unless
you have a working model.

As pointed out in the above thread (by David Brownell, not by me), many
masters expect the slave to respond within one SPI clock cycle (between
the last bit of the command and the first bit of the response).  On a
400MHz PXA processor, I have measured interrupt latency in excess of
600us (100us min, 200us typ), so that would imply a maximum SPI clock of
1kHz for generalized slave operation.  I'm not sure how many
applications would be happy with that; likely a few.  I don't think use
of real time threads will decrease the latency significantly; that is to
say: whatever reduced latency is achievable is likely to still present a
significant limit on SPI clock rate for the general case.

If, on the other hand, you mean to develop restricted slave capability,
such as the always-predictable case of data-streaming between a single
slave/master pair, that would be different.   That is the way my slave
application (and likely others) work.  Note that I did not need any
changes to the SPI core for that application, only to the device drivers.

I don't mean to be negative, just realistic.  It's only worth adding
this capability if there is a clear case that it will be useful in practice.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
