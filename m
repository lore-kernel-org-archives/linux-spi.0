From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add support for
	dma_min_bytes configuration.
Date: Thu, 8 Apr 2010 10:27:24 -0600
Message-ID: <p2nfa686aa41004080927u9de9eeafrfbfb32efd3358912@mail.gmail.com>
References: <1270550389-30392-1-git-send-email-roman.tereshonkov@nokia.com>
	<z2rfa686aa41004072326z5ff8c044l46330b85dfd7ae74@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC339@NOK-EUMSG-02.mgdnok.nokia.com>
	<s2vfa686aa41004080808o443dd6b7ge4d23c513a1f80a8@mail.gmail.com>
	<E1C7579D1379824DAE67858071C8103828208BC539@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org
To: roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E1C7579D1379824DAE67858071C8103828208BC539-xJW1crHCIS+8kqYwC468Frtp2NbXvJi8gfoxzgwHRXE@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 8, 2010 at 9:25 AM,  <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:
>
> The others from wlan team need DMA_MIN_BYTES to be adjustable.
> Juuso can comment this.

Fair enough.  I'm happy to either take both parts of the patch through
the spi tree, or for the changes to go in via the omap tree.  There is
no sense in splitting them up.

g.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
