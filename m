From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
Date: Tue, 4 Feb 2020 13:05:28 +0200
Message-ID: <CAHp75VfHAS46-kMyg7Ky4jn7zmkht6wd9ayCfn+rrO0R6aNr6A@mail.gmail.com>
References: <20200203223003.4567-1-eajames@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
To: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200203223003.4567-1-eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 4, 2020 at 12:30 AM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>
> There exists a set of SPI controllers on some POWER processors that may
> be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
> engine that can access and drive the SPI controllers. This driver would
> typically be used by a baseboard management controller (BMC).
>
> The SPI controllers operate by means of programming a sequencing engine
> which automatically manages the usual SPI protocol buses. The driver
> programs each transfer into the sequencer as various operations
> specifying the slave chip and shifting data in and out on the lines.

Some comments left unsettled in v1, thus applicable here.

-- 
With Best Regards,
Andy Shevchenko
