From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH 3/3] spi: img-spfi: Increase DMA burst size
Date: Mon, 22 Dec 2014 11:22:39 -0800
Message-ID: <CAL1qeaGEDXeESRaGVQPAt1PkYHax_k1J+1iV215OfMQsqwUUng@mail.gmail.com>
References: <1418763946-22260-1-git-send-email-abrestic@chromium.org>
	<1418763946-22260-3-git-send-email-abrestic@chromium.org>
	<20141222175423.GE17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sifan Naeem <sifan.naeem@imgtec.com>, linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141222175423.GE17800@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 22, 2014 at 9:54 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Dec 16, 2014 at 01:05:46PM -0800, Andrew Bresticker wrote:
>
> > A 1-byte burst size is rather inefficient and has been shown to cause
> > TX issues during testing.  Increase the DMA burst size to 4-bytes for
> > both RX and TX DMA when using the 8-bit FIFO.
>
> This sounds like a fix for transmit issues so should go before patch 2
> (which seems like it is a performance improvement rather than a bug fix)
> but it depends on that patch - can you respin in the opposite order
> please?

Yes, will do.
