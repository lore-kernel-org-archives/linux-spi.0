From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH 05/11] DT: marvell,mmp2: Add SSP1 and SSP3
Date: Mon, 29 Oct 2018 16:35:29 +1100
Message-ID: <20181029053529.GG29685@us.netrek.org>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-6-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-6-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 10, 2018 at 07:09:30PM +0200, Lubomir Rintel wrote:
> There seem to be SSP2, SSP4 and perhaps SSP5 too, but Marvel keeps their
> base addresses secret.
> 
> The SSP1 and SSP3 addresses were taken from OLPC 1.75, OpenFirmware and
> kernel respectively.

Sorry for the delay.  Love your work!  From my notes, SSP2 is
0xd4036000, and SSP4 is 0xd4039000.  Can be probed by hand in
OpenFirmware or CForth once clocks are on.

-- 
James Cameron
http://quozl.netrek.org/
