From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ep93xx: added chip revision
	reading function
Date: Fri, 26 Mar 2010 15:40:01 +0000
Message-ID: <56d259a01003260840sacc120ep7fd74ab2c33a8c4a@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976368AC725D@AUSP01VMBX24.collaborationhost.net>
	<20100325090638.GA20512@gw.healthdatacare.com>
	<0D753D10438DA54287A00B02708426976368F66FD1@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517588b980b33d60482b5fa5e
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B02708426976368F66FD1-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--001517588b980b33d60482b5fa5e
Content-Type: text/plain; charset=ISO-8859-1

On 3/25/10, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
>  For parts 1 and 3.
>
>  I tried testing them in my setup with the mmc_spi.c and sst25l.c drivers.  Both
>  did not work.  For some reason the data read is always either 0x00 or 0xff.
>
>  I will try to get some time this week/weekend to look into this.

I got these working with the Sim.One board without modification.
The data rate when dd'ing from the block device is slightly slower
than the Cirrus Logic patches (222kB/s instead of 235kB/s), and I got
the same kind of write errors at the same frequency as we did with the
Cirrus code, but this seems to be some problem with our board. Unlike
the CIrrus code, it successfully retries failed multi-block read
requests using single-block reads.

In case it's useful to you, I attach the first hack of the
modifications I made to the board description file
I'm not sure it's right, and I haven't coded in the use of the
MMC-card-present GPIO interrupt line yet, but it "seems to work" ^TM

    M

--001517588b980b33d60482b5fa5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--001517588b980b33d60482b5fa5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--001517588b980b33d60482b5fa5e--
