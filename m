From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH v3] spi: core: Validate length of the transfers in
 message
Date: Thu, 27 Feb 2014 22:38:26 +0900 (JST)
Message-ID: <20140227.223826.522636360.anemo@mba.ocn.ne.jp>
References: <1392890528-7417-1-git-send-email-iivanov@mm-sol.com>
	<20140225.225528.453119424.anemo@mba.ocn.ne.jp>
	<20140226001407.GM2927@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: iivanov@mm-sol.com, gsi@denx.de, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140226001407.GM2927@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 26 Feb 2014 09:14:07 +0900, Mark Brown <broonie@kernel.org> wrote:
>>       + optionally defining short delays after transfers ... using
>>         the spi_transfer.delay_usecs setting (this delay can be the
>>         only protocol effect, if the buffer length is zero);
> 
> *sigh*  I guess it is valid, though frankly I'm concerned that this
> isn't a good idea - it's certainly not going to work reliably given the
> need for every driver to open code this, most of them get the delay
> stuff wrong.

I don't object to the whole patch.  Validating in spi core is good of
course, and "xfer->len % w_size" part looks no problem.

I just want to keep ways to handle an odd device, for example, which
requires long delay between chipselect and the first transfer, etc.

---
Atsushi Nemoto
