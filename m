From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
Date: Wed, 3 Nov 2010 05:35:54 -0700 (PDT)
Message-ID: <129498.93810.qm@web180302.mail.gq1.yahoo.com>
References: <AANLkTin=3K0H+YdNM2Nhz63c3+Upp+rwApo-Ww4p5qH6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <AANLkTin=3K0H+YdNM2Nhz63c3+Upp+rwApo-Ww4p5qH6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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



--- On Wed, 11/3/10, Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
\
> Date: Wednesday, November 3, 2010, 3:18 AM
> 2010/11/3 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:
> 
> > That seems like
> > a better structure for various vendors' "SSP"
> > hardware (multifunction serial interface logic)
> 
> Incidentally the ARM PrimeCell PL022 is called SSP,
> "Synchronous Serial Port" and is not multifunction at all.

ISTR coming across that IP module; are you sure
that it only supports a single serial protocol,
instead of just a "small" variety" (multi)?
Unless the hardware only supports one protocol,
my point holds.

I wasn't implying that modules named SSP have
more in common than tending to support
more than a single serial protocol.  If they
only support one, they get names like"USART"
or sometimes CODEC.

- Dave
