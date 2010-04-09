From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add support for
	dma_min_bytes configuration.
Date: Thu, 8 Apr 2010 22:56:35 -0600
Message-ID: <z2tfa686aa41004082156tb4b150fao671ed749cb83c9e1@mail.gmail.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
	<z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC339@NOK-EUMSG-02.mgdnok.nokia.com>
	<s2vfa686aa41004080808o443dd6b7ge4d23c513a1f80a8@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC539@NOK-EUMSG-02.mgdnok.nokia.com>
	<1270785939.10120.1141.camel@wimaxnb.nmp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"Tereshonkov Roman \(Nokia-D/Helsinki\)" <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,
	Samuel Ortiz <samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org>
To: Juuso Oikarinen <juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1270785939.10120.1141.camel-gZysiALljqf+W+uuys5jPoH6Mc4MB0Vx@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 8, 2010 at 10:05 PM, Juuso Oikarinen
<juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
> AFAIK performing the SPI transfer optimally should not affect other SPI
> clients in a negative way, and AFAIK there are no other SPI clients in
> Dali than the wl1271, so I guess this new threshold value could also be
> hard-coded into the omap2_mcspi driver.

Okay, good.  Then I recommend preparing and posting a patch to change
the default value.  Include the rational behind the change, how you
came up with the final number, and be sure to cc: the original
developer of that driver.

g.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
