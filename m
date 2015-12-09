From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/3] acpi: Rename acpi_gsi_get_irq_type to
 acpi_get_irq_type and export symbol
Date: Wed, 9 Dec 2015 16:19:46 +0200
Message-ID: <CAHp75Vfc=YT8TrUHo2Tdd=4e9-C=rQY126wraKpyn0B-=0n3-w@mail.gmail.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
	<1449527952-8399-2-git-send-email-christophe-h.ricard@st.com>
	<20151208112855.GI1766@lahna.fi.intel.com>
	<5667523F.60704@gmail.com>
	<20151209133646.GV1766@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christophe Ricard <christophe.ricard@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Christophe Ricard <christophe-h.ricard@st.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151209133646.GV1766@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 9, 2015 at 3:36 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Dec 08, 2015 at 10:57:19PM +0100, Christophe Ricard wrote:
>> I believe changes done in this patch take benefit of another existing
>> function used in acpi gsi context that is doing the
>> job as expected.
>>
>> Do you still believe acpi_dev_irq_flags is more appropriate ?
>
> I don't have strong feelings about that. I just wanted to point out
> there already exists such function.
>
> However, if you do use acpi_gsi_get_irq_type() I think it should be
> placed to the same file as acpi_dev_irq_flags().

And perhaps renamed accordingly

acpi_dev_get_irq_type() I suppose.


-- 
With Best Regards,
Andy Shevchenko
