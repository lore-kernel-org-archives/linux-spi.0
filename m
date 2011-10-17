From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/pl022: elevate workqueue to realtime priority
Date: Mon, 17 Oct 2011 15:09:34 +0200
Message-ID: <CACRpkdZpQLEh0GqeB4y2mcSj2a5f+KzdZqkeF68MCnMAhNEMnQ@mail.gmail.com>
References: <1317884611-22168-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1317884611-22168-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 6, 2011 at 9:03 AM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:

> From: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>
> The PL022 is used in performance-critical applications where we
> need soft realtime response from the SPI data pipe. Elevating the
> workqueue to realtime has been proven to improve response times
> for us, so we propose to make this change permanent.
>
> Signed-off-by: Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> [Commit message written by me]
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Grant, drop this patch. create_rt_workqueue() is deleted
from the kernel, we need to figure out a better way to
elevate our priorities. (I wonder how...)

(Patch [1/2] should still be OK though.)

Yours,
Linus Walleij

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
