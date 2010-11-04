From: David Brownell <david-b@pacbell.net>
Subject: Re: spi_butterfly null ptr dereference on unload module
Date: Thu, 4 Nov 2010 13:19:58 -0700 (PDT)
Message-ID: <596240.50099.qm@web180307.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
To: lkml <linux-kernel@vger.kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--- On Thu, 11/4/10, Randy Dunlap <randy.dunlap@oracle.com> wrote:

> Date: Thursday, November 4, 2010, 12:46 PM
> Just load and unload the module.

For the record ... at first impression this
feels like a regression in another part of
the kernel than the driver you indicate.
I used to do that load/unload semi-regularly,
with no errors appearing.

However, I can't do any real testing on this,
now, since I no longer have parport-capable
hardware to which I can hook up one of these adapters ... and thus collect more info about
where the bit-rot has rooted.

- Dave
