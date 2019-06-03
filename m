From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Date: Mon, 3 Jun 2019 17:56:00 +0200
Message-ID: <CAKv+Gu8rTernjct93rsWo0X3FTp6bsV=0JvNGQr8C8OaqB1S7A@mail.gmail.com>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
 <20190603110832.GA2781@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-spi@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190603110832.GA2781@lahna.fi.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, 3 Jun 2019 at 13:08, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:
> > @@ -1948,7 +1988,8 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
> >       if (!handle)
> >               return;
> >
> > -     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>
> Would it be simpler to differentiate here between Apple and non-Apple
> systems? Then we don't need all that special code and the above becomes:
>
>         depth = x86_apple_system ? 1 : SPI_ACPI_ENUMERATE_MAX_DEPTH;
>         status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, depth,
>         ..
>
> Probably requires a comment explaining why we do it like that, though.

Yes, but note that both the root and the depth are different in this case.

I'll play around with this idea, to see if it simplifies things.
