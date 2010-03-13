From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] spi: overhaul davinci spi driver to correct
	multiple errors
Date: Fri, 12 Mar 2010 16:22:44 -0800
Message-ID: <87k4th2hpn.fsf@deeprootsystems.com>
References: <1268422520-22642-1-git-send-email-bniebuhr@efjohnson.com>
	<1268422520-22642-2-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1268422520-22642-2-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org> (Brian
	Niebuhr's message of "Fri\, 12 Mar 2010 13\:35\:19 -0600")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> This patch is a significant overhaul of the davinci spi controller driver
> that corrects multiple errors:
>
> - Eliminate a race condition that exists for slow SPI devices
> - Fix DMA transfer length error
> - Fix limitations preventing multiple SPI devices on the same controller
>
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

The verbose description of the issues addressed from PATCH 0/2 should
go here is well so it makes it into the permanent git history.

That being said, I think for the sake of reviewing, you're going to
need to break this up into reviewable pieces, each having a verbose
description of the issues being solved.

There is also a mixture of fixes, enhancements, renames etc.  These
should be done as separate patches. 

I know that it's more work to break it up like this, but that's the
only way to make a large change like this reviewable by others.

Thanks,

Kevin
