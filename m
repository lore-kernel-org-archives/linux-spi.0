Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C7BC07548
	for <linux-spi@archiver.kernel.org>; Wed, 15 Nov 2023 08:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjKOIgn (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 15 Nov 2023 03:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOIgm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Nov 2023 03:36:42 -0500
Received: from mail.tradestry.pl (mail.tradestry.pl [141.94.250.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3B10F
        for <linux-spi@vger.kernel.org>; Wed, 15 Nov 2023 00:36:38 -0800 (PST)
Received: by mail.tradestry.pl (Postfix, from userid 1002)
        id 4BDAAA4C25; Wed, 15 Nov 2023 08:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradestry.pl; s=mail;
        t=1700037397; bh=Y0HnXqH+26AP5Uq6M8BQXaj1HIAPQY/WndV9tkpAHHU=;
        h=Date:From:To:Subject:From;
        b=Y6qWLE2oUEBniyGNx4KCKlLBWnxUr3QZt9+ppOts44dYo91CsaJEjJ7snm9k5Emg9
         NvLHQ20AfgkLqpB1LzPmmbbiB1rjAzmDoI/QFny4al3LHX0+LZosOYSCfsilpID9CC
         f0v9PuUBhR5MNYtF7UKIdFHp5bQx/eluJRav31hEN3SDqq4HnDOp+BvrE73LYguHz1
         5HFsOewXeR42cMDbC4NDOphsMH84AELpRGaCZnu6RtXdEbq4fXCCs3A5H4riHcjUik
         m2JFZeKYMV5iJblJgEvIqOY9BvLpHq/X7M6df29+xOg0s9+uxXlgSYPFek4FdzpUqC
         vy3EdK4rF2QIg==
Received: by mail.tradestry.pl for <linux-spi@vger.kernel.org>; Wed, 15 Nov 2023 08:36:04 GMT
Message-ID: <20231115074501-0.1.dp.1ke4e.0.de4irzln5r@tradestry.pl>
Date:   Wed, 15 Nov 2023 08:36:04 GMT
From:   "Damian Cichocki" <damian.cichocki@tradestry.pl>
To:     <linux-spi@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.tradestry.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Damian Cichocki
