From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Documentation/spi/spidev_test.c  "Message too long" -EMSGSIZE
Date: Fri, 4 Mar 2011 14:52:49 -0700
Message-ID: <20110304215249.GA7579@angua.secretlab.ca>
References: <1299270617.2338.34.camel@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kevyn-Alexandre =?iso-8859-1?Q?Par=E9?= <kapare-7qmld2CjetYf4mhTGKTGE9BPR1lH4CV8@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1299270617.2338.34.camel@andromeda>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Mar 04, 2011 at 03:30:17PM -0500, Kevyn-Alexandre Par=E9 wrote:
> Hi,
> =

> I just try to transfer 32775 bytes with spidev_test.c and receive this
> message:
> can't send spi message: Message too long
> =

> Since driver/spi/spidev.c validate that count is not bigger then bufsiz
> that is 4096. Because of this:
> =

> static unsigned bufsiz =3D 4096;
> module_param(bufsiz, uint, S_IRUGO);
> MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");

That's just broken.  There shouldn't be any limit on the size of an
spi message sent from userspace.  If userspace can pass the buffer,
then the spi layer should be able to send it.

It looks like it should be possible to modify spidev to handle large
transfers.

> =

> Question1: Anyone have made some test with buffer bigger then 4096 and se=
e any reason not going to something like 32775?
> =

> Question2: Since this parameter is S_IRUGO I have no other choice then us=
ing the driver as module if I want to change this size!?

You should be able to pass a different default value in the kernel
parameters string at boot time.

g.

---------------------------------------------------------------------------=
---
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
