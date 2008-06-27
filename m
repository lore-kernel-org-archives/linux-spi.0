From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: Accelerometer etc subsystem (Update on progress)
Date: Thu, 26 Jun 2008 19:39:12 -0700
Message-ID: <20080626193912.5c66c32b.randy.dunlap@oracle.com>
References: <4832A211.4040206@gmail.com>
	<20080520132817.03fb74ea@hyperion.delvare>
	<4863D97A.9090102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Dmitry Torokhov <dtor@mail.ru>, Ben Dooks <ben@fluff.org>,
	mgross@linux.intel.com, hmh@hmh.eng.br,
	"Hans J. Koch" <hjk@linutronix.de>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757261AbYF0CrW@vger.kernel.org>
In-Reply-To: <4863D97A.9090102@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 26 Jun 2008 19:01:30 +0100 Jonathan Cameron wrote:

>     Documenation ;)

and Documentation ;)


Ugh.  Attachment.  Please send patches inline so that they can be reviewed
without having to do tons of copy-and-paste.  Possibly Documentation/email-clients.txt
can help you with thunderbird.

There are several typos in the Kconfig text parts...
and in source code comments.

>From Documentation/CodingStyle:

The preferred style for long (multi-line) comments is:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

Please review/use Documentation/CodingStyle.

This Makefile (drivers/industrialio/misc/Makefile)
doesn't seem to do anything.

---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
