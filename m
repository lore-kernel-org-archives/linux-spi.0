From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] atmel_spi: support zero length transfer
Date: Thu, 21 Feb 2008 11:23:34 -0800
Message-ID: <20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
 <200802201855.02605.marc.pignat@hevs.ch>
 <20080221.105233.41199605.nemoto@toshiba-tops.co.jp>
 <200802211026.17816.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, hskinnemoen@atmel.com
To: marc.pignat@hevs.ch, anemo@mba.ocn.ne.jp
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759627AbYBUTXs@vger.kernel.org>
In-Reply-To: <200802211026.17816.marc.pignat@hevs.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> David, do you think writing 0 bytes is a valid use of this API?

Just a zero byte transfer ... no, though it depends what you mean
by "valid".  (I'm not sure I'd expect all controller drivers to
reject such requests.)  That has no effect on bits-on-the-wire,
and would make trouble for various DMA engines.

Passing zero bytes to get an inline delay at an exact spot in the
overall protocol message ... I don't see why not.  Better than
adding delay fields for every spot it might be needed by various
oddball devices, for sure!!


> IMHO, we should add a fied to the spi_transfer struct.

What would that do, exactly?

This *specific* usage might arguably belong in spi_device, since
it's a delay required after chipselect goes active and before any
bytes get transferred.  It's clearly not a per-transfer thing, and
should also apply after a temporary mid-message chip deselect.

And it would probably deserve a mode flag (sigh) unless someone
can update every master controller driver.

- Dave
