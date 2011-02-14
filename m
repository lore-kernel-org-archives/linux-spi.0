From: Philippe =?iso-8859-1?q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: mc13xxx-core, support for i2c, V4
Date: Mon, 14 Feb 2011 11:21:34 +0100
Message-ID: <201102141121.34676.philippe.retornaz@epfl.ch>
References: <1294119299-18352-1-git-send-email-marc@cpdesign.com.au>
	<20110212084035.GB17755@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
	Marc Reilly <marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110212084035.GB17755@angua.secretlab.ca>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Le samedi, 12 f=E9vrier 2011 09.40:35, Grant Likely a =E9crit :
> On Tue, Jan 04, 2011 at 04:34:55PM +1100, Marc Reilly wrote:
> > Hi,
> >
> > These patches add i2c support for the mc13xxx-core drive. For v4 I've
> > tried to take in all previous comments, hopefully making it better to
> > follow, and bisectable.
> =

> This series looks okay to me.  Since this is audio drivers, I expect
> that it would best be taken via the ASoC tree?  Have you sent it to
> Mark Brown and the ALSA list for review?

AFAIK the audio part of the mc13783 has still not been merged.

Regards,

Philippe
