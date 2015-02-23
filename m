From: =?UTF-8?Q?aur=C3=A9lien_bouin?= <a.bouin@gmail.com>
Subject: Re: [PATCH 3/4] spi: imx: Chose DMA bits per word transfered
Date: Mon, 23 Feb 2015 16:25:51 +0100
Message-ID: <CAFeThoD+k0DMM=dCzxO1bmC=32W_9g1pCgevNyKNsv_kzaRHeg@mail.gmail.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
	<1423742848-15369-3-git-send-email-a.bouin@gmail.com>
	<20150221143528.GU6236@finisterre.sirena.org.uk>
	<CAFeThoDBstQ_=gsi2o509qqQR6PbV4MxsNe=hEhKj4Mj162osA@mail.gmail.com>
	<20150223144626.GE6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fabio Estevam <festevam@gmail.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150223144626.GE6236@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2015-02-23 15:46 GMT+01:00 Mark Brown <broonie@kernel.org>:
> On Mon, Feb 23, 2015 at 09:44:50AM +0100, aur=C3=A9lien bouin wrote:
>> At the moment there is no possibility to change the dma bits per wor=
d use ...
>> It is an easy way to be able to do so.
>> Feel free to propose something better
>
> Once more don't top post.  To repeat what I said:
>
> | Why would this be a DT property?  It seems like something the drive=
r
> | ought to be able to figure out automatically if it matters.
>
> The above doesn't address my question.
Currently the driver does not figure it out automatically, it is a fix
8bits per word DMA use.
