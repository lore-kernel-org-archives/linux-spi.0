From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] spi: bitbang: Fix NULL pointer dereference in spi_unregister_master
Date: Thu, 16 May 2019 16:36:59 +0800
Message-ID: <CAFRkauCSzkuNUugsfGY8jvcy-2hd-LfkuerJi56V3OM6oHu3yw@mail.gmail.com>
References: <20190516075656.25880-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Alban Bedel <albeu@free.fr>, lorenzo.bianconi@redhat.com
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516075656.25880-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

YueHaibing <yuehaibing@huawei.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=8816=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> If spi_register_master fails in spi_bitbang_start
> because device_add failure, We should return the
> error code other than 0, otherwise calling
> spi_bitbang_stop may trigger NULL pointer dereference
> like this:

Reviewed-by: Axel Lin <axel.lin@ingics.com>
