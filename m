From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Date: Tue, 25 Feb 2020 11:31:37 -0600
Message-ID: <20200225173137.GA31830@bogus>
References: <20200215065826.739102-1-gch981213@gmail.com>
 <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
To: Chuanhong Guo <gch981213@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 20, 2020 at 07:58:06AM +0800, Chuanhong Guo wrote:
> Hi!
> 
> On Tue, Feb 18, 2020 at 8:55 PM Mark Brown <broonie@kernel.org> wrote:
> > This is an ABI break so you shouldn't be doing this, if the existing
> > binding works it should continue to work.
> 
> The missing spi-max-frequency is the only part preventing old
> device tree to work with this driver.
> If the goal is to make existing dt binding work, I could patch dt using
> of_add_property in v2. I saw similar device tree patching for legacy
> bindings in pinctrl-single driver.

You should should really only need 'spi-max-frequency' if the max freq 
is less than the minimum of the host and device max freq.

Rob
