From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 08/12] gpio: add ti-ssp virtual gpio driver
Date: Thu, 21 Oct 2010 17:00:53 -0700 (PDT)
Message-ID: <72577.70502.qm@web180304.mail.gq1.yahoo.com>
References: <4CC0CF7C.1030908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        "lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>,
        "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: cyril-l0cyMroinI0@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4CC0CF7C.1030908-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org



> > Doesn't look particularly evil, except I don't much
> like the notion of
> > needing a "stack" if it's not being used
> like an MFD where numerous
> > functions are accessed concurrently,
> better IMO to just have each function's driver bind exclusively to the ch=
ip (and
> drive it in the
> > mode it supports -- SPI, GPIO etc).
> =

> SPI and GPIO are not the only modes that
> this hardware can be programmed

I know; ergo the "etc".  This is common for
serial engines.  Many have enough flexibility
to hook up to several flavors of audio codec too.


> to behave in.=A0 In future, other functions may be added
> as needed.=A0 =


And each one would have its own driver.

> I thought it would be best to keep the
> shared stuff reusable.

The way I've seen that done in the past is to
keep the register decls clean enough so most
drivers  use them directly ... and in a few
cases, provide some library code (if there is a
a good reason to share any logic).  (But it often
turned out that the functions couldn't share much
beyond the register layouts, since behaviors of
each function  differ so widely.

> =


=A0
> there's not a
> > thing "virtual" about this.
