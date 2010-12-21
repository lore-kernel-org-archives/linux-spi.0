From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH] GPIO chip select support for McSPI
Date: Tue, 21 Dec 2010 12:56:34 -0500
Message-ID: <1292954195-20204-1-git-send-email-bgamari.foss__28446.0686882541$1292954246$gmane$org@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: beagleboard <beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Michael Henn
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1b68c6791001272033q60dd31dbif4de285cd9bac83d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


As you may recall, about a year ago I wrote wondering whether it was possible
to use GPIO lines as chip selects in the McSPI driver. A few of you pointed out
that this functionality had been added to other drivers and it should be quite
simple to do the same for McSPI. Two semesters then passed without a followup
from me.

Thankfully, classes are over and I've had some downtime due to sickness,
finally freeing up some time to look at this (just in time as we'll soon need
this functionality). This morning I looked through the relevant code and put
together this patch to add support for GPIO CSs. As was suggested, I modelled
this after the approach taken in the s3c24xx-spi driver. Let me know whether
this looks sane. It has yet to see hardware, but in principle things look
alright (famous last words).

Cheers,

- Ben


P.S. In case people are curious to see an example of usage I have a patch
adding support for multiplexed chip selects to support a data acquisition board
for the BeagleBoard that I've been working on[1]. I can send these out if
people are interested.

[1] http://goldnerlab.physics.umass.edu/wiki/BeagleBoardDaq


------------------------------------------------------------------------------
Forrester recently released a report on the Return on Investment (ROI) of
Google Apps. They found a 300% ROI, 38%-56% cost savings, and break-even
within 7 months.  Over 3 million businesses have gone Google with Google Apps:
an online email calendar, and document program that's accessible from your 
browser. Read the Forrester report: http://p.sf.net/sfu/googleapps-sfnew
