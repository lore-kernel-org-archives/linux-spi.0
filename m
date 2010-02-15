From: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SPI-ADC
Date: Mon, 15 Feb 2010 17:49:41 +0900
Message-ID: <1b68c6791002150049v60c21c3cha9ac12014355dfec@mail.gmail.com>
References: <dc6d3181002122148v6451ebffka164de288738485d@mail.gmail.com>
	<63386a3d1002130548y7c839072y85097a9bcdf66cad@mail.gmail.com>
	<4B76D8AE.7040102@jic23.retrosnub.co.uk>
	<63386a3d1002131320u5afbc35ak2bc3533aab3f1e54@mail.gmail.com>
	<dc6d3181002142029j13a9e57la45aa90a269404fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>,
	linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <dc6d3181002142029j13a9e57la45aa90a269404fa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 15, 2010 at 1:29 PM, arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Let us try and see .If any body is having a reference driver for SPI based
> ADC,they can share.
Don't think you need to anything 'ADC specific' all u need is to _use_
your SPI driver.
grep for spi_sync in linux/drivers/ and refer to any spi user driver.

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
