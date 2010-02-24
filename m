From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 24 Feb 2010 07:25:25 -0700
Message-ID: <fa686aa41002240625l332d8e94xb3bcbea1c265a581@mail.gmail.com>
References: <20091229222006.1ddb28a4@feng-desktop> <20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org> <fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
	<20100209093644.2dead2d9@feng-i7> <20100217225817.GD31557@kroah.com>
	<20100224131130.61530b62@feng-i7> <20100224104419.753dd138@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Feng Tang <feng.tang@intel.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-list <spi-devel-general@lists.sourceforge.net>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20100224104419.753dd138@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 24, 2010 at 3:44 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Wed, 24 Feb 2010 13:11:30 +0800
> Feng Tang <feng.tang@intel.com> wrote:
>
>> Hi All,
>>
>> Here is a driver for Maxim 3110 SPI-UART device, please help to review.
>>
>> It has been validated with Designware SPI controller (drivers/spi: dw_spi.c &
>> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read, and
>> provides a console.
>
> Ack for the serial side
>
> Acked-by: Alan Cox <alan@linux.intel.com>

Ack for the SPI side

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
