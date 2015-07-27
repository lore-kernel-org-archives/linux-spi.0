From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing gpio_request_one
Date: Mon, 27 Jul 2015 09:34:41 -0700
Message-ID: <CAL1qeaHLn6-2QJkPjNCm3V-pVqBk09P2BP-Sp+gn1G4ZWpvkEw@mail.gmail.com>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
	<1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	"Stable kernel (v4.1)" <stable@vger.kernel.org>
To: Sifan Naeem <sifan.naeem@imgtec.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sifan,

On Mon, Jul 27, 2015 at 5:11 AM, Sifan Naeem <sifan.naeem@imgtec.com> wrote:
> spfi_setup may be called many times bye the spi framework, but
> gpio_request_one can only be called once without freeing, repeatedly
> calling gpio_request_one will cause an error to be thrown, which causes
> the request to spi_setup to be marked as failed.
>
> We can simply use gpio_direction_output to set the direction of the
> gpio instead of gpio_request_one to put the gpio in to initial state,
> after which the spi framework can control the chipselect line via gpio
> using gpio_set_value.

I don't think we want to leave the CS GPIOs un-requested.  Instead, we
could either request them all at probe() time (and then set direction
in setup()) or have a per-spi_device flag that indicates whether or
not the GPIO has been requested.

-Andrew
