From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
Date: Tue, 2 Nov 2010 19:15:16 -0700 (PDT)
Message-ID: <956998.65651.qm@web180302.mail.gq1.yahoo.com>
References: <1288124308-14999-9-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org,
        grant.likely@se
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1288124308-14999-9-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
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



--- On Tue, 10/26/10, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> wrote:

> From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
> Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver

On the assumptions you've tested this *AND* will
resubmit with the previously-requested change of
removing all references to non-existent
"virtual"ness in the driver ... I'll likely
add my ack to that resubmitted version

Also, chip2gpio seems an excessively generic name;
maybe chip2_ti_ssp_gpio or somesuch?

I'd still be happier seeing this "stack" packaged
as a hardware library called by various drivers
(like GPIO, SPI, etc) rather than a core driver
that's called by other drivers.  That seems like
a better structure for various vendors' "SSP"
hardware (multifunction serial interface logic)
since most function drivers just need to poke
the registers a bit differently, and don't have
much to share with a "core driver" beyond a few
setup routines (if that).

- Dave
