From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 3/3] max3100: adds console support for MAX3100
Date: Mon, 22 Mar 2010 09:31:57 +0800
Message-ID: <20100322093157.705bf458@feng-i7>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	<1268987997-22746-1-git-send-email-chripell@fsfe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"greg@kroah.com" <greg@kroah.com>,
	"david-b@pacbell.net" <david-b@pacbell.net>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Christian Pellegrin <chripell@fsfe.org>
To: Christian Pellegrin <chripell@fsfe.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1268987997-22746-1-git-send-email-chripell@fsfe.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 19 Mar 2010 16:39:57 +0800
Christian Pellegrin <chripell@fsfe.org> wrote:

> +#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
> +
> +static void max3100_console_putchar(struct uart_port *port, int ch)
> +{
> +	struct max3100_port *s = container_of(port, struct
> max3100_port, port);
> +	unsigned long tout = 10 * HZ / 1000; /* 10ms */
> +	unsigned long start;
> +	u16 tx, rx;
> +
> +	if (tout == 0)
> +		tout = 1;
> +	start = jiffies;
> +	do {
> +		tx = MAX3100_RC;
> +		max3100_sr(s, tx, &rx);

Hi Christian,

You'd better not call max3110_sr (which calls spi_sync) here, a console's
putchar() func may be called in some atomic context.

I used similar method when I started to implement a console, but then I switch
to current method in my 3110 driver: save the printk buffer inside putchar,
and wake up a thread to really handle the spi transfer later.

Thanks,
Feng
> +	} while ((rx & MAX3100_T) == 0 &&
> +		 !time_after(jiffies, start + tout));
> +	tx = ch;
> +	max3100_calc_parity(s, &tx);
> +	tx |= MAX3100_WD | MAX3100_RTS;
> +	max3100_sr(s, tx, &rx);
> +}
> +
> +static void max3100_console_write(struct console *co,
> +				  const char *str, unsigned int
> count) +{
> +	struct max3100_port *s = max3100s[co->index];;
> +
> +	uart_console_write(&s->port, str, count,
> max3100_console_putchar); +}

