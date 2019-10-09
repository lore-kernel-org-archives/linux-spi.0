From: Vladimir Oltean <olteanv@gmail.com>
Subject: Re: Applied "spi: Add a PTP system timestamp to the transfer
 structure" to the spi tree
Date: Thu, 10 Oct 2019 01:57:25 +0300
Message-ID: <CA+h21hoDAuKwLj--pbm=TGaO0PKwUeTUFDu=36KjDN+XwP80jw@mail.gmail.com>
References: <20190905010114.26718-3-olteanv@gmail.com> <20191008105254.99A6D274299F@ypsilon.sirena.org.uk>
 <CA+h21hoid_bQ37qC30fDt62ces40PwSQ2v=KHTGkadV_ycrd5A@mail.gmail.com>
 <20191008164259.GQ4382@sirena.co.uk> <20191009151348.2e2e2383@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        linux-spi@vger.kernel.org, Miroslav Lichvar <mlichvar@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191009151348.2e2e2383@cakuba.netronome.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 10 Oct 2019 at 01:14, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Tue, 8 Oct 2019 17:42:59 +0100, Mark Brown wrote:
> > On Tue, Oct 08, 2019 at 03:58:51PM +0300, Vladimir Oltean wrote:
> >
> > > Dave, do you think you can somehow integrate this patch into net-next
> > > as well, so that I can send some further patches that depend on the
> > > newly introduced ptp_sts member of struct spi_transfer without waiting
> > > for another kernel release?
> >
> > Ugh, it'd have been good to have been more aware of this before applying
> > things since I put them on the one development branch (I used to make
> > more topic branches but Linus doesn't like them).  I've pulled things
> > out into a branch with a signed tag for merging into other trees:
> >
> > The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> >
> >   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-ptp-api
> >
> > for you to fetch changes up to 79591b7db21d255db158afaa48c557dcab631a1c:
> >
> >   spi: Add a PTP system timestamp to the transfer structure (2019-10-08 17:38:15 +0100)
> >
> > ----------------------------------------------------------------
> > spi: Add a PTP API
> >
> > For detailed timestamping of operations.
> >
> > ----------------------------------------------------------------
> > Vladimir Oltean (1):
> >       spi: Add a PTP system timestamp to the transfer structure
> >
> >  drivers/spi/spi.c       | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/spi/spi.h |  61 +++++++++++++++++++++++
> >  2 files changed, 188 insertions(+)
>
> Thanks for the branch, I pulled it into net-next, it should show up once
> build testing is done.

Thanks to both of you, Jakub and Mark!

-Vladimir
